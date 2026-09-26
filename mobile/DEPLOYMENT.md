# Mobile Deployment Guide — Google Play Store

This document provides end-to-end instructions for deploying the **Bona Loko** mobile application (`habit-builder`) to the Google Play Store, covering both the **First Deployment** and **Future Updates/Releases**.

---

## 📋 Quick Reference & Project Metadata

| Attribute | Project Setting |
| :--- | :--- |
| **Project Directory** | `mobile/habit-builder` |
| **Package Name (Application ID)** | `com.bonaloko.habit_builder` |
| **App Name** | `Bona Loko` |
| **Framework & Engine** | Flutter 3.24+ / Dart 3.5+ |
| **Release Artifact** | Android App Bundle (`.aab`) |
| **Local Keystore Path** | `mobile/habit-builder/android/app/upload-keystore.jks` |
| **Keystore Config File** | `mobile/habit-builder/android/key.properties` |
| **Store Assets Folder** | `mobile/habit-builder/assets/images/android-deployment/` |
| **Public Privacy Policy URL** | `https://bonaloko.com/privacy` |

---

## 🛠️ Part 1: Pre-Requisites & One-Time Local Setup

Before generating a release build, ensure local signing credentials and assets are in place.

### 1. Keystore Configuration (`key.properties`)
Ensure [`mobile/habit-builder/android/key.properties`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/android/key.properties) has your real keystore passwords:

```properties
storePassword=YOUR_ACTUAL_STORE_PASSWORD
keyPassword=YOUR_ACTUAL_KEY_PASSWORD
keyAlias=upload
storeFile=upload-keystore.jks
```

> [!IMPORTANT]
> - Never commit `key.properties` or `*.jks` files to version control. They are already listed in [`android/.gitignore`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/android/.gitignore).
> - Back up `upload-keystore.jks` and its passwords in a secure password manager. If you lose this key, you will not be able to update your app on Google Play without resetting it through Google Support.

### 2. Verify Store Listing Graphics
Ensure the store listing graphics in [`assets/images/android-deployment/`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/assets/images/android-deployment/) meet the exact Google Play dimensions:

- **App Icon:** `app_icon_512.png` (512 × 512 px, 32-bit PNG, max 1MB)
- **Feature Graphic:** `banner.png` (1024 × 500 px, 24-bit RGB PNG/JPEG, no transparency, max 15MB)
- **Phone Screenshots:** At least 2 screenshots (e.g. `financial_management_screen.png`, `physical_activities_screen.png`)

---

## 🚀 Part 2: First-Time Deployment (Step-by-Step)

### Step 1: Run Quality Checks & Tests
From `mobile/habit-builder`:
```bash
flutter analyze
flutter test
```
Verify that all tests pass with zero errors.

### Step 2: Build the Production App Bundle (`.aab`)
Google Play strictly requires an **Android App Bundle (`.aab`)** for new submissions:

```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

The generated file will be located at:
```
mobile/habit-builder/build/app/outputs/bundle/release/app-release.aab
```

#### Native Debug Symbols (Resolving Google Play Warning)
When your app uses native libraries (such as Flutter engine or SQLite), Google Play requests a debug symbols file so crash reports and ANRs can be symbolicated.

There are two ways to satisfy this:

- **Method A: Direct Upload to Google Play Console (Immediate)**
  A symbol file is generated from the unstripped native libraries:
  ```
  mobile/habit-builder/build/app/outputs/bundle/release/native-debug-symbols.zip
  ```
  In **Google Play Console** $\rightarrow$ **App Bundle Explorer** $\rightarrow$ select your bundle release $\rightarrow$ click the **Downloads** tab $\rightarrow$ scroll down to **Debug symbols** $\rightarrow$ click **Upload** and upload `native-debug-symbols.zip`.

- **Method B: Embedded in AAB (Automatic with NDK)**
  In [`android/app/build.gradle`](./habit-builder/android/app/build.gradle), `ndk { debugSymbolLevel 'FULL' }` (or `'SYMBOL_TABLE'`) is configured in `buildTypes.release`. When the Android NDK is installed, Gradle automatically packages these symbols inside `BUNDLE-METADATA/com.android.tools.build.debugsymbols/` in the `.aab`.

---

### Step 3: Set Up the App in Google Play Console

1. Navigate to the [Google Play Console](https://play.google.com/console).
2. Click **Create App**:
   - **App Name:** `Bona Loko`
   - **Default Language:** English (United States) — `en-US` or Portuguese (Brazil) — `pt-BR`
   - **App or Game:** App
   - **Free or Paid:** Free
   - Accept the Developer Program Policies and US Export Laws, then click **Create app**.

---

### Step 4: Complete Policy Declarations & App Content

Google requires filling out mandatory policy questionnaires before submitting:

1. **Privacy Policy:**
   - Link: `https://bonaloko.com/privacy`
2. **App Access:**
   - Select: *"All functionality is available without special access"* (no login or credentials required).
3. **Ads:**
   - Select: *"No, my app does not contain ads"*.
4. **Content Rating (IARC Questionnaire):**
   - Provide your contact email.
   - Category: Select **Utility / Productivity / Lifestyle**.
   - Answer the questionnaire (violence: No, sexual content: No, profanity: No, etc.).
   - Rating awarded will typically be **Everyone / PEGI 3**.
5. **Target Audience and Content:**
   - Target age: **18 and over** (or 16–17 / 18+).
   - Could your app unintentionally appeal to children: **No**.
6. **Financial Features Declaration:**
   - Because the app has the *Gestão Financeira* section, Google requires declaring its purpose:
   - Select **Personal Financial Management (PFM)** or **Expense Tracking**.
   - Indicate: Does **not** provide banking, lending, credit, or crypto trading services.
7. **Data Safety Form:**
   - Does your app collect or share user data: Select **No**.
   - Explanation: All habits, life area evaluations, gratitude entries, physical activities, and financial entries are stored **100% locally on the device in an embedded SQLite database (Drift)** and are never transmitted to external servers.

---

### Step 5: Store Listing Assets & Copy

Under **Grow** $\rightarrow$ **Store presence** $\rightarrow$ **Main store listing**:

1. **App Details:**
   - **App Name:** `Bona Loko`
   - **Short Description (max 80 chars):**
     *EN:* `Cultivate daily habits, gratitude, life balance, and mindful financial clarity.`
     *PT:* `Cultive hábitos diários, gratidão, equilíbrio de vida e gestão financeira.`
   - **Full Description (max 4000 chars):** Highlight the 12 life areas, daily gratitude practice, customized physical routines, and local monthly financial tracking.
2. **Graphics:**
   - Upload **App Icon:** [`assets/images/android-deployment/app_icon_512.png`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/assets/images/android-deployment/app_icon_512.png)
   - Upload **Feature Graphic:** [`assets/images/android-deployment/banner.png`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/assets/images/android-deployment/banner.png)
   - Upload **Phone Screenshots:** At least 2 phone screenshots from [`assets/images/android-deployment/`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/assets/images/android-deployment/).

---

### Step 6: Create the Release & Upload the Bundle

1. Go to **Release** $\rightarrow$ **Testing** $\rightarrow$ **Internal testing** (or **Closed testing** / **Production**).
2. Click **Create new release**.
3. **Play App Signing:** Ensure Google Play App Signing is enabled (Google manages the distribution key, while your `upload-keystore.jks` signs the upload bundle).
4. **App Bundles:** Drag and drop `mobile/habit-builder/build/app/outputs/bundle/release/app-release.aab`.
5. **Release Name:** Auto-fills as `1.0.0 (1)`.
6. **Release Notes:** Add release notes (in English and Portuguese).
7. Click **Next**, review any warnings, and click **Save** / **Start rollout**.

> [!NOTE]
> **Personal Developer Account Requirement (Policy since Nov 2023):**
> If your Google Play Developer Account is personal (registered after Nov 13, 2023), Google requires you to run a **Closed Test with at least 20 opted-in testers for at least 14 days** before applying for production access. Organization accounts can release directly to production after review.

---

## 🔄 Part 3: Future Deployments & Updates

Follow this streamlined workflow whenever releasing a new update or patch.

### Step 1: Bump Version in `pubspec.yaml`
Open [`mobile/habit-builder/pubspec.yaml`](file:///c:/github_accounts/assertivecode/bona-loko/mobile/habit-builder/pubspec.yaml):

```yaml
# Before:
version: 1.0.0+1

# After (increment build number by +1 each release):
version: 1.0.1+2
```

- **`1.0.1` (`versionName`):** The visible version number users see in the store (SemVer: `Major.Minor.Patch`).
- **`+2` (`versionCode`):** An integer that **must strictly increase** with every single upload to Google Play. Google Play will reject any upload with an identical or lower `versionCode`.

### Step 2: Validate the Code
```bash
flutter analyze
flutter test
```

### Step 3: Build the New Release Bundle
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

### Step 4: Upload to Google Play Console
1. In Google Play Console, go to **Release** $\rightarrow$ **Production** (or your active track).
2. Click **Create new release**.
3. Upload the newly built `.aab` file:
   `mobile/habit-builder/build/app/outputs/bundle/release/app-release.aab`
4. Enter release notes highlighting new features or bug fixes.
5. Click **Review release**, then **Start rollout to Production** (or configure a staged rollout, e.g. 20% $\rightarrow$ 50% $\rightarrow$ 100%).

---

## 🔍 Troubleshooting & Common Issues

| Issue | Cause | Solution |
| :--- | :--- | :--- |
| `keystore password was incorrect` | `key.properties` has incorrect password or placeholder | Verify passwords in `mobile/habit-builder/android/key.properties` match the `keytool` password. |
| `Version code has already been used` | Google Play already has an artifact with that `versionCode` | Increment the number after the `+` in `pubspec.yaml` (e.g. `1.0.2+3`) and rebuild. |
| `Feature Graphic must be 1024x500` | Banner image has non-compliant dimensions | Use `assets/images/android-deployment/banner.png` which is formatted to 1024 × 500 px. |
| `App Icon must be 512x512` | Icon image has non-compliant dimensions | Use `assets/images/android-deployment/app_icon_512.png` which is formatted to 512 × 512 px. |
| `Target SDK version is too low` | Play Store requires target API level 34+ | Handled by Flutter 3.24+ default in `android/app/build.gradle` (`targetSdk = flutter.targetSdkVersion`). |
