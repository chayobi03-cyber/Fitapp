plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.chayobi03.fitapp"
    compileSdk = 36
    defaultConfig {
        applicationId = "com.chayobi03.fitapp"
        minSdk = 29
        targetSdk = 35
        versionCode = 1
        versionName = "0.1.0-m0"
    }
    buildTypes { release { isMinifyEnabled = false } }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
}

dependencies {
    implementation(files("libs/samsung-health-data-api.aar"))
    implementation("androidx.activity:activity-ktx:1.10.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.9.2")
}
