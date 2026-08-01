# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-08-01

### Changed — BREAKING

- **Repository renamed and transferred**: `flutter-ui-library` has moved from `github.com/aks5686/flutter-ui-library` to `github.com/Syzygy-Hub/syzygy-ui-flutter`.
  - **pub.dev package renamed**: `aks5686_flutter_ui_library` → `syzygy_ui_flutter` (Dart package naming rules require underscores, not hyphens, so this doesn't match the `syzygy-ui-flutter` repo name exactly — that's expected).
  - **Consumers must update their pubspec.yaml dependency** to `syzygy_ui_flutter: ^2.0.0` and their imports to `package:syzygy_ui_flutter/syzygy_ui_flutter.dart`. No API-level renames were made to existing components.

### Added

- **Inputs**: `SearchInput` (debounced, clear button), `ToggleSwitch`, `CheckboxInput`, `RadioButtonInput`, `SliderInput`, `Dropdown`, `SegmentedControl`, `QuantityStepper`. The `*Input` names (and `SliderInput`) avoid colliding with Flutter Material's own `Checkbox`/`Radio`/`Slider`/`SearchBar`.
- **Display** (new category): `Avatar`, `DividerLine`, `Chip`, `ListRow`, `SectionHeader`, `LazyImageView` (uses Flutter's core `Image.network`, which handles async loading/caching natively), `StarRatingView`, `CountBadge`. `Chip` hides Flutter Material's own `Chip`, the same convention already used by this library's `Badge`.
- **Feedback**: `ShimmerView`, `ProgressBar`, `PullToRefresh` (wraps core `RefreshIndicator`), `ErrorStateView` (retry pattern, mirrors `EmptyStateView`).
- **Overlay** (new category): `ModalDialog` (wraps `showDialog`), `BottomSheet` (wraps `showModalBottomSheet`; hides Material's own `BottomSheet`), `CollapsibleView` (via `AnimatedCrossFade`).
- **Navigation**: `TabBar`, `BottomNavigationBar` (floating icon-only pill — a visual alternative to `TabBar`), `SyzygyAppBar` (implements `PreferredSizeWidget`, so it drops straight into `Scaffold(appBar: ...)`). `TabBar` and `BottomNavigationBar` hide their Material namesakes, the same convention already used by `Badge`. `SyzygyAppBar` uses a distinct name instead of hiding, since `AppBar` is used far more pervasively by consumers than `Badge`/`TabBar` — forcing a `hide AppBar` on every file importing both this package and Material would be too disruptive.
- **Layout** (new category): `KeyboardAvoidingScrollView`, `PagerView` (wraps `PageView` — no naming collision, since Flutter's own widget is named `PageView`, not `PagerView`; categorized under Layout rather than Navigation since it's swipeable paged content, not navigation chrome — `onPageChanged` just reports the current page index for the caller to use as local state or feed into a navigator, as needed).
- **Transitions** (new): `NavigationTransitions.slideTransition`, `.crossFadeTransition`, `.slideVerticalTransition`, `.modalPresentationTransition` — `PageRouteBuilder` factories, following Flutter's own custom-transition idiom.

### Fixed

- CI's `Analyze` step now fetches the shared Dart analysis config from `syzygy-lint-config` (pinned to `v1.0.0`) instead of using only the local `analysis_options.yaml`.
- Replaced deprecated `Color.withOpacity` with `Color.withValues` in `ShimmerView` to keep `flutter analyze` clean under the shared config (which fails the build on any finding, including info-level).
- **Bumped the declared minimum SDK** in `pubspec.yaml` from `flutter: '>=3.10.0'` to `flutter: '>=3.27.0'` (`sdk: '>=3.6.0'`) — the previous minimum was stale and didn't actually reflect the `Color.withValues()` API used in `ShimmerView`, which was introduced in Flutter 3.27 / Dart 3.6.

### Documentation

- README's Components list previously named `IconButton`/`BackButton`, which don't match the actual class names (`AppIconButton`/`AppBackButton`) — corrected.
- README's Usage section previously used `MaterialTheme`-style pseudocode that doesn't match this library's real `AppTheme`/`AppColors.of(context)` API — corrected to a working example.

## [1.0.1] - 2026-07-30

- TextInput: added maxLength parameter with character counter.
- Renamed package to aks5686_flutter_ui_library.
- Updated installation to use pub.dev.
- Improved release workflow with automatic pub.dev publishing.

## [1.0.0]

- Initial release.
- Components: PrimaryButton, SecondaryButton, DestructiveButton, GhostButton, IconButton, TextInput, SecureInput, LoadingView, EmptyStateView, ToastView, CardView, Badge, BackButton.
- Design tokens: colors, typography, spacing, radius.
- Full Dark Mode support via ThemeExtension.
- 18 tests passing.
