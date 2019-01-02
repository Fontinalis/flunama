# flunama

A flutter package for Mapbox widget. Can create a Maobix map widget for Android and iOS,
features are now limited and the package is **still under  development**.

## Getting Started

### Android

1. Have to add the following line to `android/app/build.gradle`.

```implementation 'com.mapbox.mapboxsdk:mapbox-android-sdk:6.7.2'```

2. Add the following line to `MainActivity.java`.

`Mapbox.getInstance(this, "<--mapbox_token_here-->");`

### iOS

1. Do a `pod install` in your folder