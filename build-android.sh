#!/usr/bin/env bash
# Build the Android debug APK. Requires JDK 21 + Android SDK installed.
set -e
export JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home -v 21)}"
export ANDROID_HOME="${ANDROID_HOME:-/opt/homebrew/share/android-commandlinetools}"
npm run copy:www
npx cap sync android
( cd android && ./gradlew assembleDebug --console=plain )
echo "APK -> android/app/build/outputs/apk/debug/app-debug.apk"
