# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

---

## [2.5.0] - 2026-09-04

### Changed

- CI workflow improvements: tags-ignore trigger, lint order fix, Node/runner updates
- Release workflow: added required permissions block
- RN: added publish-npm job for reliable npm OIDC publishing

---

## [2.4.0] - 2026-08-05

### Added
- SyzygyTheme, SyzygyThemeProvider InheritedWidget, runtime theme switching via builder callback
- 3 built-in themes: defaultTheme, dark, highContrast
- Component-level theme override via theme constructor parameter

### Changed
- All components now read visual tokens from SyzygyThemeProvider.of(context)

### Fixed
- Accessibility: PhoneInput (Semantics label), SearchableDropdown (field + items), Popover (container)

## [2.3.0] - 2026-08-05

### Changed (Breaking)
- **Color token vocabulary alignment** — `AppColorsLight`, `AppColorsDark`, and `AppColors` updated to canonical token set:
  - New tokens added: `primarySubtle`, `errorMuted`, `textPrimary`, `textSecondary`, `textDisabled`, `textInverse`, `scrim`
  - All tokens wired through constructor required params, `copyWith`, `lerp`, `light`/`dark` static consts, and both inner color classes

### Fixed
- CI `release.yml`: `seq 1 10` → `seq 1 30` in pub.dev poll loop (300 s → 900 s max wait) to allow for slower registry propagation

## [2.2.1] - 2026-08-04

### Added
- `Timeline`: renamed `TimelineItemData` → `TimelineItem` — cross-platform naming alignment (breaking rename)
- `Accordion`: `initiallyOpenIndex: int?` → `initiallyOpenIndexes: Set<int>` — lets callers pre-open multiple sections simultaneously (breaking rename; pass `{0}` to replicate the old single-index behaviour)

### Fixed
- `AppRadius.full`: corrected from `999.0` to `9999.0` to match cross-platform token spec
- `ConfirmDialog`: wrapped content in `Semantics(liveRegion: true)` so TalkBack/VoiceOver announces the dialog on appearance

## [2.2.0] - 2026-08-04

### Added

- **Display**: `PageControl` (aka `DotIndicator`; read-only row of dots synced with `PagerView`'s current page — no tap-to-navigate, since a page indicator reflects state rather than driving it), `Accordion` (managed group of `CollapsibleView`-style sections sharing open/closed coordination state; single-open-at-a-time by default via `allowMultipleOpen`), `Timeline` (aka `ActivityFeed`; vertical event list with a dot/icon connector line via simple fixed-height segments, not a `CustomPainter`), `ColorSwatchView` (circle/square swatch with optional label and `isSelected` border using the `focus` color token — named `ColorSwatchView`, not `ColorSwatch`, since Flutter Material already exports a framework class named `ColorSwatch<T>`).
- **Inputs**: `SearchableDropdown` (standalone `TextField` + filtered option list via an anchored `OverlayEntry`, following `Popover`'s existing `CompositedTransformTarget`/`CompositedTransformFollower` pattern — not a wrapper around this library's `Dropdown`, since `DropdownButtonFormField` has no hook for inline search/filtering), `PhoneInput` (tappable flag-emoji + dial-code prefix selector, numeric keyboard, reports both a digits-only `raw` value and a `formatted` display string; ships with a minimal, real, overridable 15-country default list), `CurrencyInput` (currency symbol prefix/suffix with hand-rolled thousands-separator grouping from Dart core — no new `intl` dependency).
- **Feedback**: `NetworkStatusBanner` ("No internet connection" banner — a controlled/presentational widget taking a required `isOffline` prop, since Flutter's core SDK has no built-in connectivity-detection API the way iOS's `NWPathMonitor`/Android's `ConnectivityManager` do natively), `ConfirmDialog` (preset `ModalDialog` variant: title/message/confirm/cancel, with `isDestructive` styling on the confirm button).
- **Layout**: `SafeAreaWrapper` (themed wrapper around Flutter's own native `SafeArea` — exposes a consistent `syzygy_ui_flutter`-named API surface over an already-solved problem, unlike this release's genuinely dependency-constrained components), `LabeledDivider` (centered/leading/trailing text label breaking a line, built from two `DividerLine` segments).

Nothing to report for `### Fixed` this release — no CI/lint carry-over was assigned to this repo.

## [2.1.0] - 2026-08-03

### Added

- **Buttons**: `LoadingButton` (built-in spinner, disabled while loading), `AppFloatingActionButton` (avoids colliding with Material's own `FloatingActionButton`), `ButtonGroup` (single/multi-select segmented row).
- **Inputs**: `TextArea` (multi-line, via `TextField`'s native `minLines`/`maxLines`), `OTPInput` (auto-advancing focus per digit), `TagInput` (renders entered items as dismissible `Chip`s), `DatePickerField`/`TimePickerField` (wrap Flutter's native `showDatePicker`/`showTimePicker`), `AppFormField` (avoids colliding with Flutter's own `FormField<T>` base class), `PasswordStrengthIndicator` (real length + character-class heuristic, not hardcoded).
- **Display**: `AvatarGroup` (overlapping `Avatar` stack with "+N" overflow), `StatsCard` (aka `MetricCard`; label/value/trend), `RatingInput` (interactive counterpart to the read-only `StarRatingView`).
- **Feedback**: `SkeletonView` (rectangle/circle shimmer placeholder, generalizing `ShimmerView`'s animation), `CircularProgress` (themed wrapper around Material's own determinate/indeterminate `CircularProgressIndicator`), `InlineAlert` (aka `Banner`; 4 variants using new `*Muted` color tokens — named to avoid colliding with both Material's `Banner` and `MaterialBanner`), `AppSnackbar` (a `SnackBar`-building factory for `ScaffoldMessenger.showSnackBar`, rather than reinventing Material's overlay/queueing system).
- **Overlay**: `ActionSheet` (labelled actions in a bottom sheet, following `BottomSheet`'s existing `.show(context, ...)` convention), `Popover` (anchored floating content via `CompositedTransformTarget`/`CompositedTransformFollower`), `AppTooltip` (themed wrapper around Material's own `Tooltip`, avoiding a name collision).
- **Navigation**: `SideMenu` (aka `Drawer`; wraps Material's own `Drawer` for `Scaffold(drawer: ...)` integration rather than a fully custom overlay), `FloatingTabBar` (floating pill bar with icon **and** label per item — fills the gap left by `TabBar` (edge-to-edge + labeled) and `BottomNavigationBar` (floating + icon-only)), `StepIndicator` (aka `WizardSteps`), `Breadcrumbs`.
- **Layout**: `AdaptiveStack` (Row above a breakpoint, Column below, via `LayoutBuilder`), `FlowLayout` (thin wrapper over Flutter's native `Wrap`), `StickyHeader` (via `CustomScrollView` + `SliverPersistentHeader`).
- **Transitions**: `NavigationTransitions.scaleTransition`, `.fadeThroughTransition` (sequenced fade-out-then-fade-in via non-overlapping `Interval`s, not a simultaneous cross-fade).
- **Design Tokens**: new color tokens `primaryMuted`, `destructiveMuted`, `successMuted`, `warningMuted`, `surfaceSecondary`, `surfaceTertiary`, `textTertiary`, `overlay`, `link`, `focus`, `separator` (light + dark); `AppTypography.largeTitle`; spacing `xxs`/`xxxl`; radius `xs`/`xl`; new token files/categories `AppElevation`, `AppOpacity`, `AppBorderWidth`, `AppIconSize`, `AppAnimationDuration`/`AppAnimationEasing`.

### Changed

- README's Design Tokens section condensed from per-token prose paragraphs to compact markdown reference tables, for both existing and newly added token categories.

No carry-over patch fixes were needed in this repo for this release — the PagerView Layout-vs-Navigation categorization fix landed in a previous release and required no further changes here.

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

[2.5.0]: https://github.com/Syzygy-Hub/syzygy-ui-flutter/compare/2.4.0...2.5.0
[2.4.0]: https://github.com/Syzygy-Hub/syzygy-ui-flutter/compare/2.3.0...2.4.0
