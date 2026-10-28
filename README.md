# Boomgratulations Flutter starter

This is a Flutter Android starter that matches the requested light-red football app design.

## Included
- Fixtures, Live, Results, Picks and Account tabs
- Green Win, gold Draw and red Lost indicators
- League-position badges directly beside each team
- Position colors: 1–3 green, 4–15 yellow/gold, 16+ red (demo rule; adjust to each league's actual relegation zone)
- Small serif text to approximate Times New Roman
- GitHub Actions workflow that builds a release APK

## Important
The displayed fixtures, scores, standings and picks are sample/demo data. This ZIP does **not** contain a compiled APK and does not fetch real match data yet. Real data requires API-Football integration. Do not put an API key in Flutter source or in a public repository; use a backend or secret-managed service.

## Build APK using GitHub (phone-friendly route)
1. Create/open a GitHub repository and upload the contents of this ZIP (not the ZIP file itself) to the repository root.
2. Make sure `pubspec.yaml`, `lib/main.dart`, `README.md` and `.github/workflows/build-apk.yml` are visible at the root.
3. Open **Actions** in the repository.
4. Select **Build Boomgratulations Android APK**.
5. Tap **Run workflow** (if it has not started automatically), then open the completed run.
6. Under **Artifacts**, download `boomgratulations-release-apk`.
7. Extract the downloaded artifact ZIP to find `app-release.apk`, then install it on your Android phone.

If GitHub asks to enable Actions, enable them for this repository first.

## Local build
Install Flutter and Android SDK, then run:
```bash
flutter pub get
flutter create --platforms=android --org com.boomgratulations .
flutter build apk --release
```

APK output:
`build/app/outputs/flutter-apk/app-release.apk`

## Font note
The app uses Flutter's generic serif font as a close match. Exact Times New Roman requires adding a licensed font file to the project and registering it in `pubspec.yaml`.
