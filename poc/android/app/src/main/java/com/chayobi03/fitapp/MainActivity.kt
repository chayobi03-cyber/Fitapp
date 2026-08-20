package com.chayobi03.fitapp

import android.os.Bundle
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.lifecycle.lifecycleScope
import com.samsung.android.sdk.health.data.HealthDataService
import com.samsung.android.sdk.health.data.device.DeviceGroup
import com.samsung.android.sdk.health.data.permission.Permission
import com.samsung.android.sdk.health.data.request.AccessType
import com.samsung.android.sdk.health.data.request.DataType
import com.samsung.android.sdk.health.data.request.DataTypes
import com.samsung.android.sdk.health.data.request.LocalTimeFilter
import java.time.LocalDate
import java.time.LocalDateTime
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : ComponentActivity() {
    private val store by lazy { HealthDataService.getStore(applicationContext) }
    private val stepsPermission = setOf(Permission.of(DataTypes.STEPS, AccessType.READ))

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val output = TextView(this).apply {
            setPadding(32, 32, 32, 32)
            text = "Fitapp M0 POC\nInitializing…"
        }
        setContentView(output)

        lifecycleScope.launch {
            try {
                val granted = store.getGrantedPermissions(stepsPermission).grantedPermissions
                if (!granted.containsAll(stepsPermission)) {
                    output.text = "Fitapp M0 POC\nRequesting STEPS read permission…"
                    store.requestPermissions(stepsPermission, this@MainActivity)
                }

                val start = LocalDate.now().atStartOfDay()
                val end = LocalDateTime.now()
                val request = DataType.StepsType.TOTAL.requestBuilder
                    .setLocalTimeFilter(LocalTimeFilter.of(start, end))
                    .build()

                val result = withContext(Dispatchers.IO) { store.aggregateData(request) }
                val steps = result.dataList.firstOrNull()?.value ?: 0L

                val bands = withContext(Dispatchers.IO) {
                    store.getDeviceManager().getDevices(DeviceGroup.BAND)
                }

                output.text = buildString {
                    appendLine("Fitapp M0 POC")
                    appendLine("STATUS: EXECUTION")
                    appendLine("local_start=$start")
                    appendLine("local_end=$end")
                    appendLine("steps=$steps")
                    appendLine("band_devices=${bands.size}")
                    bands.forEach {
                        appendLine("band id=${it.id} type=${it.deviceType} manufacturer=${it.manufacturer} model=${it.model} name=${it.name}")
                    }
                }
            } catch (t: Throwable) {
                output.text = "Fitapp M0 POC\nERROR\n${t.javaClass.simpleName}: ${t.message}"
            }
        }
    }
}
