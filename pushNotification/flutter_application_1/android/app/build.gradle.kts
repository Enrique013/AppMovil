// ...existing code...
plugins {

    id("com.android.application")

    id("kotlin-android")

    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.

    id("dev.flutter.flutter-gradle-plugin")

    // id("com.google.gms.google-services")  // <- eliminado
}

// ...existing code...
dependencies {

  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:34.5.0"))

  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")
  
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries

}

// ...existing code...
android {
    namespace = "com.example.flutter_application_1"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.flutter_application_1"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// Aplica el plugin desde el classpath definido en el buildscript del root
apply(plugin = "com.google.gms.google-services")