# Yaki Mobile

Mobile front-end of the Yaki application.
This mobile application allows users to connect and declare themselves on site, missing or remote.

## Requirement

- An IDE : [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
- [Flutter](https://docs.flutter.dev/get-started/install)

## Used library :

- [state management library](https://pub.dev/packages/flutter_riverpod) : State management
- [translation library](https://pub.dev/packages/easy_localization) : Traduction
- [API call library](https://pub.dev/packages/retrofit) : API Call
- [Serialization](https://pub.dev/packages/json_serializable) : Data Serialization (JSON)
- [Navigation](https://pub.dev/packages/go_router) : Manage navigation
- [Flutter SVG](https://pub.dev/packages/flutter_svg) : Dart implementations of SVG parsing
- [Shared Preferences](https://pub.dev/packages/shared_preferences) : Wraps platform-specific persistent storage for simple data
- [Mockito](https://pub.dev/packages/mockito) : Mock library for Dart
- [Golden Toolkit](https://pub.dev/packages/golden_toolkit) : Lets you quickly test various states of your widgets

## Run on the web

**Compilation**

```bash
flutter build web --release --dart-define API_BASE_URL=https://www.api-base-url.com/
docker build -t yaki-mobile-web .
```

**Run**

```bash
docker run -p 8080:80 yaki-mobile-web
```

.
