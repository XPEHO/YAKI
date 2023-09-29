# Maestro mobile UI tests

This section relates to automated UI tests using Maestro mobile tool.

## Prerequisites

* [Maestro](https://maestro.mobile.dev/)
* [Install](https://maestro.mobile.dev/getting-started/installing-maestro)

## Running tests

To run tests, use the following command:

```bash
cd ./yaki_mobile/
flutter build apk --debug --dart-define-from-file=config.json
adb install build/app/outputs/flutter-apk/app-debug.apk
cd ./maestro/
maestro test first_flow.yaml
```