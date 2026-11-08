# Abadan Haly

Abadan Haly is a Flutter carpet catalog for the [Abadan Haly company](https://abadanhaly.com.tm/). Customers can browse products and prepare orders offline; staff can upload pending orders when a catalog API is available.

## Development

Use Flutter 3.47.8, Dart 3.13, and JDK 17. The Android application ID and iOS bundle ID are `com.gurbanov.haly`.

```sh
flutter pub get
flutter run

dart format --output=none --set-exit-if-changed lib test
flutter analyze --no-fatal-infos
flutter test
flutter build apk --debug
flutter build ios --simulator --no-codesign
```

The app starts in `lib/main.dart`. Catalog import and local storage are in `lib/app/data/data_service.dart`; screens and controllers are in `lib/app/modules`. The app stores the last valid catalog and pending orders on the device. The API base URL can be changed in Settings. A successful import requires `GET /api/sync`; uploading pending orders uses `POST /api/sync/orders`.

## Release prerequisites

The configured default API host, `https://carpet.sada-devs.com`, did not resolve from the development environment on 8 November 2026. The [company website](https://abadanhaly.com.tm/) responds, but `/api/sync` there returns 404. The backend owner must confirm the intended production API URL and test catalog import and order upload on a real device. A timeout after an order upload may leave its server status uncertain; the backend should confirm how it deduplicates repeated `order_id` values before retry behavior is relied on.

The repository has no verified Google Play or App Store listing for this app. Confirm the application IDs with the store records before publishing. Android release builds require the correct keystore and `android/key.properties` outside Git; they no longer use the debug key. Test an upgrade, offline catalog use, order creation, and upload on real devices before a store or GitHub release. No signed release artifact is included here.

CI runs formatting, analysis, the catalog cache regression test, and Android/iOS debug or simulator builds. A passing build does not prove the remote API or order upload works.
