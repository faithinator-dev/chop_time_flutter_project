# ChopTime Flutter Project

Flutter application built with Dart and Flutter.

## Project structure

- `lib/main.dart` — application entry point and root widget.
- `lib/router/` — application navigation.
- `lib/theme/` — theme and platform system-chrome handling.
- `lib/motion/` — reusable animation primitives, motion presets, and route transitions.
- `test/` — widget and application tests.

## Development

Install the Flutter SDK, then run:

```sh
flutter pub get
flutter analyze
flutter test
```

The current Dart package identifier is `recipe_studio`; the root widget is `ChopTimeApp`. The package identifier is intentionally unchanged in this cleanup to avoid breaking imports and platform configuration.

See [motion system provenance](docs/MOTION_PROVENANCE.md) for project-history notes about the motion scaffolding.
