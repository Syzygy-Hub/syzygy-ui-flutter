# syzygy_ui_flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.35+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![pub.dev](https://img.shields.io/pub/v/syzygy_ui_flutter)](https://pub.dev/packages/syzygy_ui_flutter)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Web-lightgrey)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://github.com/Syzygy-Hub/syzygy-ui-flutter/actions/workflows/flutter.yml/badge.svg)](https://github.com/Syzygy-Hub/syzygy-ui-flutter/actions/workflows/flutter.yml)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/Syzygy-Hub/syzygy-brand-assets/main/Assets/syzygy-banner-dark-2400.png">
  <img src="https://raw.githubusercontent.com/Syzygy-Hub/syzygy-brand-assets/main/Assets/syzygy-banner-light-2400.png" alt="Syzygy" width="500">
</picture>

Production-ready Flutter component library with design tokens, Dark Mode, and zero third-party dependencies.

## Requirements
- Flutter 3.35+
- Dart 3.9+

## Installation

Add to your `pubspec.yaml`:
```yaml
dependencies:
  syzygy_ui_flutter: ^2.0.0
```

Then run:
```sh
flutter pub get
```

## Components

Several components are named to avoid colliding with Flutter Material's own widgets of the same name — either by using a distinct name (e.g. `SliderInput` instead of `Slider`, `SyzygyAppBar` instead of `AppBar`), or by hiding Material's version in favor of this library's (e.g. `import 'package:flutter/material.dart' hide TabBar;`), the same way this library's own `Badge` already hides Material's `Badge`. Any collision-hiding component is noted below.

- **Buttons:** PrimaryButton, SecondaryButton, DestructiveButton, GhostButton, AppIconButton
- **Inputs:** TextInput, SecureInput, SearchInput (debounced, with clear button), ToggleSwitch, CheckboxInput, RadioButtonInput, SliderInput, Dropdown, SegmentedControl, QuantityStepper
- **Display:** Avatar, DividerLine, Chip *(hides Material's `Chip`)*, ListRow, SectionHeader, LazyImageView, StarRatingView, CountBadge
- **Feedback:** LoadingView, EmptyStateView, ToastView, ShimmerView, ProgressBar, PullToRefresh, ErrorStateView
- **Overlay:** ModalDialog, BottomSheet *(hides Material's `BottomSheet`)*, CollapsibleView
- **Navigation:** AppBackButton, TabBar *(hides Material's `TabBar`)*, BottomNavigationBar *(hides Material's `BottomNavigationBar`)*, SyzygyAppBar *(distinct name — no hide needed; implements `PreferredSizeWidget` so it still works in `Scaffold(appBar: ...)`)*
- **Cards:** CardView
- **Badges:** Badge *(hides Material's `Badge`)*
- **Layout:** KeyboardAvoidingScrollView, PagerView *(swipeable paged content, not navigation chrome; `onPageChanged` reports the current page index for you to use as local state — e.g. a carousel — or feed into a navigator, as needed)*
- **Transitions:** `NavigationTransitions.slideTransition`, `.crossFadeTransition`, `.slideVerticalTransition`, `.modalPresentationTransition` — `PageRouteBuilder` factories

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Design Tokens

All tokens live under `lib/src/tokens/`.

### Colors (`AppColors`)
Registered as a `ThemeExtension<AppColors>` via `AppTheme.light()`/`AppTheme.dark()`; resolve with `AppColors.of(context)`.

| Token | Light | Dark |
|---|---|---|
| `primary` | `#2563EB` | `#3B82F6` |
| `secondary` | `#64748B` | `#94A3B8` |
| `destructive` / `error` | `#DC2626` | `#F87171` |
| `success` | `#16A34A` | `#4ADE80` |
| `warning` | `#D97706` | `#FBBF24` |
| `surface` | `#FFFFFF` | `#1E293B` |
| `background` | `#F8FAFC` | `#0F172A` |
| `border` | `#E2E8F0` | `#334155` |
| `disabled` | `#CBD5E1` | `#334155` |

Each color also has a matching `on*` counterpart (e.g. `onPrimary`) for content placed on top of it.

### Typography (`AppTypography`)
Thin wrappers over `Theme.of(context).textTheme`: `displayLarge` · `headlineLarge` · `headlineMedium` · `titleLarge` · `titleMedium` · `bodyLarge` · `bodyMedium` · `bodySmall` · `labelLarge` · `labelSmall`.

```dart
Text('Hello', style: AppTypography.titleMedium(context))
```

### Spacing (`AppSpacing`)

| Token | Value |
|---|---|
| `xs` | 4.0 |
| `sm` | 8.0 |
| `md` | 16.0 |
| `lg` | 24.0 |
| `xl` | 32.0 |
| `xxl` | 48.0 |

### Corner Radius (`AppRadius`)

| Token | Value |
|---|---|
| `sm` | 4.0 |
| `md` | 8.0 |
| `lg` | 16.0 |
| `full` | 999.0 (pill/capsule shapes) |

## Usage

```dart
import 'package:syzygy_ui_flutter/syzygy_ui_flutter.dart';

PrimaryButton(label: 'Get Started', onPressed: () {})

TextInput(label: 'Email', controller: emailController)

Badge(text: 'New', variant: BadgeVariant.primary)
```

See the [Components](#components) list above for everything else available.

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
