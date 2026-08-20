# Fitapp M0 Android POC

Purpose: verify the official Samsung Health Data SDK path for Galaxy Fit3 data.

## POC scope
1. Request READ permission for `STEPS`.
2. Query today's total steps using local date/time.
3. Enumerate Samsung Health source devices in `DeviceGroup.BAND`.
4. Capture device ID/type/manufacturer/model/name.

## Build
Open `poc/android/` with Android Studio.

Requirements are defined by Samsung Health Data SDK v1.1.0: Android 10+, Java 17+, Samsung Health 6.30.2+, and a physical Android device. The Samsung Health Data SDK AAR is proprietary and must be downloaded separately from Samsung Developer.

Place:
`poc/android/app/libs/samsung-health-data-api.aar`

Then build the `app` debug variant.

## Device validation
On the test phone:
1. Install/enable Samsung Health.
2. Pair Samsung Galaxy Fit3 and allow synchronization.
3. Enable Samsung Health Developer Mode for Samsung Health Data SDK and Data Read.
4. Install the debug APK.
5. Grant STEPS read permission.
6. Capture the POC screen and Logcat.
7. Confirm at least one `BAND` source device is visible after Fit3 data has synchronized.

A successful APK build is not sufficient for M0 GREEN. The acceptance evidence requires a real Fit3 -> Samsung Health -> POC execution.
