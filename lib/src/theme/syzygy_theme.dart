import 'syzygy_colors.dart';
import 'syzygy_radius.dart';
import 'syzygy_typography.dart';
import 'syzygy_spacing.dart';
import 'syzygy_elevation.dart';
import 'syzygy_animation.dart';

/// Root theme object. Provide via [SyzygyThemeProvider]; access via [SyzygyThemeProvider.of].
class SyzygyTheme {
  const SyzygyTheme({
    required this.colors,
    required this.radius,
    required this.typography,
    required this.spacing,
    required this.elevation,
    required this.animation,
  });

  final SyzygyColors colors;
  final SyzygyRadius radius;
  final SyzygyTypography typography;
  final SyzygySpacing spacing;
  final SyzygyElevation elevation;
  final SyzygyAnimation animation;

  SyzygyTheme copyWith({
    SyzygyColors? colors,
    SyzygyRadius? radius,
    SyzygyTypography? typography,
    SyzygySpacing? spacing,
    SyzygyElevation? elevation,
    SyzygyAnimation? animation,
  }) => SyzygyTheme(
    colors: colors ?? this.colors,
    radius: radius ?? this.radius,
    typography: typography ?? this.typography,
    spacing: spacing ?? this.spacing,
    elevation: elevation ?? this.elevation,
    animation: animation ?? this.animation,
  );

  static const defaultTheme = SyzygyTheme(
    colors: SyzygyColors.defaultColors,
    radius: SyzygyRadius.defaultRadius,
    typography: SyzygyTypography.defaultTypography,
    spacing: SyzygySpacing.defaultSpacing,
    elevation: SyzygyElevation.defaultElevation,
    animation: SyzygyAnimation.defaultAnimation,
  );

  static const dark = SyzygyTheme(
    colors: SyzygyColors.darkColors,
    radius: SyzygyRadius.defaultRadius,
    typography: SyzygyTypography.defaultTypography,
    spacing: SyzygySpacing.defaultSpacing,
    elevation: SyzygyElevation.defaultElevation,
    animation: SyzygyAnimation.defaultAnimation,
  );

  static const highContrast = SyzygyTheme(
    colors: SyzygyColors.highContrastColors,
    radius: SyzygyRadius.sharp,
    typography: SyzygyTypography.highContrast,
    spacing: SyzygySpacing.defaultSpacing,
    elevation: SyzygyElevation.defaultElevation,
    animation: SyzygyAnimation.defaultAnimation,
  );
}
