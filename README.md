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
  syzygy_ui_flutter: ^2.2.0
```

Then run:
```sh
flutter pub get
```

## Components

79 components across 9 categories (counted individually below, excluding token/transition utility classes).

Several components are named to avoid colliding with Flutter Material's own widgets of the same name — either by using a distinct name (e.g. `SliderInput` instead of `Slider`, `SyzygyAppBar` instead of `AppBar`), or by hiding Material's version in favor of this library's (e.g. `import 'package:flutter/material.dart' hide TabBar;`), the same way this library's own `Badge` already hides Material's `Badge`. Any collision-hiding or collision-avoiding component is noted below.

- **Buttons:** PrimaryButton, SecondaryButton, DestructiveButton, GhostButton, AppIconButton, LoadingButton, AppFloatingActionButton *(distinct name — avoids colliding with Material's `FloatingActionButton`)*, ButtonGroup
- **Inputs:** TextInput, SecureInput, SearchInput (debounced, with clear button), ToggleSwitch, CheckboxInput, RadioButtonInput, SliderInput, Dropdown, SegmentedControl, QuantityStepper, TextArea, OTPInput, TagInput, DatePickerField, TimePickerField, AppFormField *(distinct name — avoids colliding with Flutter's own `FormField<T>` base class)*, PasswordStrengthIndicator, SearchableDropdown *(standalone anchored-overlay widget — not a `Dropdown` wrapper, since `DropdownButtonFormField` has no hook for inline search/filtering)*, PhoneInput (tappable flag + dial-code prefix, minimal 15-country default list, overridable), CurrencyInput (hand-rolled locale-style grouping, no `intl` dependency)
- **Display:** Avatar, DividerLine, Chip *(hides Material's `Chip`)*, ListRow, SectionHeader, LazyImageView, StarRatingView, CountBadge, AvatarGroup, StatsCard *(aka MetricCard)*, RatingInput, PageControl *(aka DotIndicator; read-only, syncs with `PagerView`)*, Accordion (managed group of `CollapsibleView`-style sections; single-open-by-default via `allowMultipleOpen`), Timeline *(aka ActivityFeed)*, ColorSwatchView *(distinct name — avoids colliding with Flutter Material's own `ColorSwatch<T>` class)*
- **Feedback:** LoadingView, EmptyStateView, ToastView, ShimmerView, ProgressBar, PullToRefresh, ErrorStateView, SkeletonView, CircularProgress, InlineAlert *(aka Banner — distinct name avoids colliding with both Material's `Banner` and `MaterialBanner`)*, AppSnackbar *(builder around Material's own `SnackBar`, not a widget — distinct name avoids colliding with Material's `SnackBar`)*, NetworkStatusBanner (consumer-driven `isOffline` prop — Flutter has no built-in connectivity API, so this doesn't self-detect), ConfirmDialog (preset `ModalDialog` variant with confirm/cancel + `isDestructive` styling)
- **Overlay:** ModalDialog, BottomSheet *(hides Material's `BottomSheet`)*, CollapsibleView, ActionSheet, Popover, AppTooltip *(distinct name — avoids colliding with Material's `Tooltip`)*
- **Navigation:** AppBackButton, TabBar *(hides Material's `TabBar`)*, BottomNavigationBar *(hides Material's `BottomNavigationBar`)*, SyzygyAppBar *(distinct name — no hide needed; implements `PreferredSizeWidget` so it still works in `Scaffold(appBar: ...)`)*, SideMenu *(aka Drawer — wraps Material's own `Drawer` for `Scaffold(drawer: ...)` integration)*, FloatingTabBar (floating pill bar, icon + label — distinct from the icon-only `BottomNavigationBar`), StepIndicator *(aka WizardSteps)*, Breadcrumbs
- **Cards:** CardView
- **Badges:** Badge *(hides Material's `Badge`)*
- **Layout:** KeyboardAvoidingScrollView, PagerView *(swipeable paged content, not navigation chrome; `onPageChanged` reports the current page index for you to use as local state — e.g. a carousel — or feed into a navigator, as needed)*, AdaptiveStack, FlowLayout, StickyHeader, SafeAreaWrapper (themed wrapper around Flutter's own native `SafeArea`), LabeledDivider (wraps `DividerLine` with a centered/leading/trailing label)
- **Transitions:** `NavigationTransitions.slideTransition`, `.crossFadeTransition`, `.slideVerticalTransition`, `.modalPresentationTransition`, `.scaleTransition`, `.fadeThroughTransition` — `PageRouteBuilder` factories

**NetworkStatusBanner — cross-platform note**: On iOS and Android, `NetworkStatusBanner` self-detects connectivity via first-party OS APIs and requires no `isOffline` prop. On React Native and Flutter, real network detection requires a third-party package that this library deliberately does not bundle, so the banner is controlled/presentational — pass `isOffline` from your own network state.

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Design Tokens

All tokens live under `lib/src/tokens/`.

### Colors (`AppColors`)
Registered as a `ThemeExtension<AppColors>` via `AppTheme.light()`/`AppTheme.dark()`; resolve with `AppColors.of(context)`. Each color also has a matching `on*` counterpart (e.g. `onPrimary`) for content placed on top of it.

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
| `primaryMuted` | `#DBEAFE` | `#1E3A8A` |
| `destructiveMuted` | `#FEE2E2` | `#7F1D1D` |
| `successMuted` | `#DCFCE7` | `#14532D` |
| `warningMuted` | `#FEF3C7` | `#78350F` |
| `surfaceSecondary` | `#F1F5F9` | `#273549` |
| `surfaceTertiary` | `#E2E8F0` | `#334155` |
| `textTertiary` | `#94A3B8` | `#64748B` |
| `overlay` | `#000000` @ 40% | `#000000` @ 60% |
| `link` | `#1D4ED8` | `#60A5FA` |
| `focus` | `#2563EB` | `#60A5FA` |
| `separator` | `#CBD5E1` | `#334155` |

### Typography (`AppTypography`)
Thin wrappers over `Theme.of(context).textTheme`: `displayLarge` · `headlineLarge` · `headlineMedium` · `titleLarge` · `titleMedium` · `bodyLarge` · `bodyMedium` · `bodySmall` · `labelLarge` · `labelSmall` · `largeTitle` (bold `displayLarge`).

```dart
Text('Hello', style: AppTypography.titleMedium(context))
```

### Spacing (`AppSpacing`)

| Token | Value |
|---|---|
| `xxs` | 2.0 |
| `xs` | 4.0 |
| `sm` | 8.0 |
| `md` | 16.0 |
| `lg` | 24.0 |
| `xl` | 32.0 |
| `xxl` | 48.0 |
| `xxxl` | 64.0 |

### Corner Radius (`AppRadius`)

| Token | Value |
|---|---|
| `xs` | 2.0 |
| `sm` | 4.0 |
| `md` | 8.0 |
| `lg` | 16.0 |
| `xl` | 16.0 (shares `lg`'s value under a distinct semantic name) |
| `full` | 999.0 (pill/capsule shapes) |

### Elevation (`AppElevation`)

| Token | Value |
|---|---|
| `none` | 0.0 |
| `sm` | 1.0 |
| `md` | 4.0 |
| `lg` | 8.0 |

### Opacity (`AppOpacity`)

| Token | Value |
|---|---|
| `disabled` | 0.38 |
| `secondary` | 0.60 |
| `overlay` | 0.54 |

### Border Width (`AppBorderWidth`)

| Token | Value |
|---|---|
| `thin` | 0.5 |
| `regular` | 1.0 |
| `thick` | 2.0 |

### Icon Size (`AppIconSize`)

| Token | Value |
|---|---|
| `sm` | 16.0 |
| `md` | 20.0 |
| `lg` | 24.0 |
| `xl` | 32.0 |

### Animation (`AppAnimationDuration` / `AppAnimationEasing`)

| Duration Token | Value |
|---|---|
| `fast` | 150ms |
| `normal` | 300ms |
| `slow` | 500ms |

| Easing Token | Maps to |
|---|---|
| `standard` | `Curves.easeInOut` |
| `decelerate` | `Curves.decelerate` |
| `accelerate` | `Curves.easeIn` |
| `spring` | `Curves.elasticOut` (closest built-in approximation — Flutter has no true physics-spring curve) |

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
