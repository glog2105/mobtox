plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    namespace = "com.mobtox"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.mobtox"
        minSdk = 23
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        ndk {
            abiFilters.addAll(setOf("armeabi-v7a", "arm64-v8a", "x86_64"))
        }
        externalNativeBuild {
            cmake {
                cppFlags += "-std=c++17"
                arguments += listOf(
                    "-DANDROID_STL=c++_shared",
                    "-DCMAKE_VERBOSE_MAKEFILE=ON"
                )
            }
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                file("proguard-rules.pro")
            )
        }
    }

    packaging {
        jniLibs.useLegacyPackaging = true
        resources.excludes += setOf(
            "**/libtox.so",
            "META-INF/**"
        )
    }
}

dependencies {
    implementation("net.zetetic:android-database-sqlcipher:4.5.3")
    implementation("androidx.security:security-crypto-ktx:1.1.0-alpha06")
}
