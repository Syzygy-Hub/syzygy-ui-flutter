# flutter_ui_library

[![pub.dev](https://img.shields.io/pub/v/flutter_ui_library)](https://pub.dev/packages/flutter_ui_library)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Web-lightgrey)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://github.com/aks5686/flutter-ui-library/actions/workflows/flutter.yml/badge.svg)](https://github.com/aks5686/flutter-ui-library/actions/workflows/flutter.yml)

Production-ready Flutter component library with design tokens, Dark Mode, and zero third-party dependencies.

## Requirements
- Flutter 3.10+
- Dart 3.0+

## Installation

Add to your `pubspec.yaml`:
```yaml
dependencies:
  flutter_ui_library:
    git:
      url: https://github.com/aks5686/flutter-ui-library.git
      ref: main
```

## Usage

```dart
import 'package:flutter_ui_library/flutter_ui_library.dart';

// Button
PrimaryButton(
  label: 'Get Started',
  onPressed: () {},
)

// Input
TextInput(
  label: 'Email',
  controller: emailController,
)

// Badge
Badge(text: 'New', variant: BadgeVariant.primary)
```

## Components
- **Buttons:** PrimaryButton, SecondaryButton, DestructiveButton, GhostButton, IconButton
- **Inputs:** TextInput, SecureInput
- **Feedback:** LoadingView, EmptyStateView, ToastView
- **Cards:** CardView
- **Badges:** Badge
- **Navigation:** BackButton

## Design Tokens
All components use semantic tokens from lib/src/tokens/ — colors, typography, spacing, and radius.

## Contributing & Releases

### Making a release
1. Make changes and ensure tests pass:
```sh
   flutter test
   flutter analyze
```
2. Commit with release prefix:
```sh
   git commit -m "release: v1.2.0 — description"
   git push origin main
```
3. CI automatically runs tests, syncs pubspec.yaml version, and creates GitHub release.

### Version format
- Patch: `v1.0.1` — bug fixes
- Minor: `v1.1.0` — new components
- Major: `v2.0.0` — breaking changes

## License
MIT
