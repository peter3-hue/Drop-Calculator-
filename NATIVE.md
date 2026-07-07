# Native app (Capacitor → Android)

The web app in this repo is wrapped as a native **Android** app with [Capacitor](https://capacitorjs.com).
Same code (`index.html`) runs on the web (GitHub Pages) and inside the native shell.

- **App name:** Drop Calculator
- **App ID:** `com.pdavisfamily.dropcalc`  *(permanent once published — do not change after store release)*
- **Web assets:** copied from repo root into `www/` (see `npm run copy:www`), then synced into `android/`.

## Toolchain (installed on this Mac)

- **JDK 21** — `brew install openjdk@21` (Capacitor 8 compiles against Java 21)
- **Android SDK** — `brew install --cask android-commandlinetools`, then:
  `sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"`
- `ANDROID_HOME=/opt/homebrew/share/android-commandlinetools`
- SDK path is recorded in `android/local.properties` (gitignored).

## Build a debug APK

```bash
./build-android.sh
# -> android/app/build/outputs/apk/debug/app-debug.apk
```

Install on a phone: transfer the APK, enable "install unknown apps," tap it. Or with a device
plugged in + USB debugging on: `adb install -r android/app/build/outputs/apk/debug/app-debug.apk`.

## After changing the web app

The web app is the source of truth. After editing `index.html` etc., re-sync before building:

```bash
npm run sync          # copy web assets into the native project
./build-android.sh    # rebuild the APK
```

## Still to do before publishing to Google Play

- **In-app purchase** for Pro (Play Billing via RevenueCat) — replaces the web Lemon Squeezy paywall
  inside the app (Play requires its own billing for digital goods).
- **Signed release build** (`./gradlew bundleRelease` with an upload keystore) → `.aab` for Play.
- **Play Console** listing: screenshots, description, privacy policy URL, content rating, $25 one-time fee.
- Bump `versionCode`/`versionName` in `android/app/build.gradle` for each release.
