onura:
Uygulamada yazılan kodların çoğu genel prensipler;
https://www.youtube.com/c/HardwareAndro
https://www.youtube.com/c/VandadNP
https://flutter.dev/learn
https://firebase.google.com/docs/flutter/setup
https://firebase.google.com/docs/flutter/setup?platform=android
https://www.youtube.com/watch?v=H6NJHb5BJyE&t=14271s

# Install
---
## If you want clone
---
clone with firebase is not working, I dont know,

## If you don't want to clone
---
open terminal
```
flutter create --org <company name or smt> <proje name>

example => flutter create --org sky.sky "myproject"

cd myproject

code .
```
After project open
```
flutter pub add firebase_core firebase_auth cloud_firestore firebase_analytics curved_navigation_bar provider
```
myproject/android/app/build.gradle should be like;
whatever you are missing, add it.
```

apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'


defaultConfig {
        applicationId "sky.sky.myproject"
        minSdkVersion 19 
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
	multiDexEnabled true
    }
	dependencies {
    ...

    implementation 'com.android.support:multidex:1.0.3'
    implementation 'com.google.firebase:firebase-analytics'
}
```

myproject/androidbuild.gradle should be like;
whatever you are missing, add it.
```

buildscript {
  repositories {

    google()  // Google's Maven repository

  }
  dependencies {

    classpath 'com.google.gms:google-services:4.3.13'

  }
}
allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository

    ...
  }
}
```
we will use the firebase CLI to make our work easier.If you have never used it before. check this out 
[Firebase CLI](https://firebase.google.com/docs/cli)

Then. write terminal which place in your project
```
firebase login (check if you are log in or not)

flutterfire configure

	<create a new project>
	name as unique 
	select all device (selected all device as default)
```
just replace your firebase_options.dart file with project's and use lib file
Don't forget open auth and cloudfirestore your firebase console 
[Firebase console](console.firebase.google.com)


