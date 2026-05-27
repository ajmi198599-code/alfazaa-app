# ALFAZAA / الفزعة

A polished Flutter UI prototype for ALFAZAA, built with mock data only.

## Run

```bash
flutter pub get
flutter run -d chrome
```

This prototype intentionally does not use Firebase, backend services, payments, sockets, or a production database.

## Google Maps setup

Phase 2 includes the official `google_maps_flutter` package with a live map architecture and mock provider simulation. Without an API key, the app keeps a premium animated fallback so demos do not break.

For real Google Maps on web, replace `GOOGLE_MAPS_API_KEY_HERE` during CI only. Enable Maps JavaScript API now, and prepare Places API, Geocoding API, and Routes/Directions API for later phases. A Vercel build command can run:

```bash
dart run tool/inject_google_maps_key.dart
flutter build web --release --dart-define=GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_API_KEY --dart-define=ALFAZAA_GOOGLE_MAPS_ENABLED=true
```

The Google Maps script loads `places,marker` libraries from `web/index.html`.
