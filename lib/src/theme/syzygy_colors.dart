import 'package:flutter/material.dart';

/// Semantic color token snapshot for injection via [SyzygyTheme].
/// [AppColorsLight] / [AppColorsDark] in tokens/colors.dart are unchanged.
class SyzygyColors {
  const SyzygyColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryMuted,
    required this.primarySubtle,
    required this.error,
    required this.onError,
    required this.errorMuted,
    required this.destructive,
    required this.onDestructive,
    required this.destructiveMuted,
    required this.success,
    required this.onSuccess,
    required this.successMuted,
    required this.warning,
    required this.onWarning,
    required this.warningMuted,
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.onSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.border,
    required this.separator,
    required this.overlay,
    required this.scrim,
    required this.link,
    required this.focus,
    required this.secondary,
    required this.disabled,
    required this.onDisabled,
    required this.overlayAlpha,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryMuted;
  final Color primarySubtle;
  final Color error;
  final Color onError;
  final Color errorMuted;
  final Color destructive;
  final Color onDestructive;
  final Color destructiveMuted;
  final Color success;
  final Color onSuccess;
  final Color successMuted;
  final Color warning;
  final Color onWarning;
  final Color warningMuted;
  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color surfaceTertiary;
  final Color onSurface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;
  final Color border;
  final Color separator;
  final Color overlay;
  final Color scrim;
  final Color link;
  final Color focus;
  final Color secondary;
  final Color disabled;
  final Color onDisabled;
  final double overlayAlpha;

  static const defaultColors = SyzygyColors(
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFFFFFFFF),
    primaryMuted: Color(0xFFDBEAFE),
    primarySubtle: Color(0xFFEFF6FF),
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorMuted: Color(0xFFFEE2E2),
    destructive: Color(0xFFDC2626),
    onDestructive: Color(0xFFFFFFFF),
    destructiveMuted: Color(0xFFFEE2E2),
    success: Color(0xFF16A34A),
    onSuccess: Color(0xFFFFFFFF),
    successMuted: Color(0xFFDCFCE7),
    warning: Color(0xFFD97706),
    onWarning: Color(0xFFFFFFFF),
    warningMuted: Color(0xFFFEF3C7),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF9FAFB),
    surfaceTertiary: Color(0xFFF3F4F6),
    onSurface: Color(0xFF111827),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    textTertiary: Color(0xFF9CA3AF),
    textDisabled: Color(0xFFD1D5DB),
    textInverse: Color(0xFFFFFFFF),
    border: Color(0xFFE5E7EB),
    separator: Color(0xFFF3F4F6),
    overlay: Color(0xFF000000),
    scrim: Color(0xFF000000),
    link: Color(0xFF2563EB),
    focus: Color(0xFF2563EB),
    secondary: Color(0xFF6B7280),
    disabled: Color(0xFFD1D5DB),
    onDisabled: Color(0xFF9CA3AF),
    overlayAlpha: 0.4,
  );

  static const darkColors = SyzygyColors(
    primary: Color(0xFF3D8BFF),
    onPrimary: Color(0xFFFFFFFF),
    primaryMuted: Color(0xFF0F2A54),
    primarySubtle: Color(0xFF061529),
    error: Color(0xFFFF6B6B),
    onError: Color(0xFFFFFFFF),
    errorMuted: Color(0xFF4A1A1A),
    destructive: Color(0xFFFF6B6B),
    onDestructive: Color(0xFFFFFFFF),
    destructiveMuted: Color(0xFF4A1A1A),
    success: Color(0xFF4CD964),
    onSuccess: Color(0xFFFFFFFF),
    successMuted: Color(0xFF0F3A1E),
    warning: Color(0xFFFFB840),
    onWarning: Color(0xFFFFFFFF),
    warningMuted: Color(0xFF4A330A),
    background: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    surfaceSecondary: Color(0xFF2C2C2E),
    surfaceTertiary: Color(0xFF3A3A3C),
    onSurface: Color(0xFFF2F2F7),
    textPrimary: Color(0xFFF2F2F7),
    textSecondary: Color(0xFF9B9BA1),
    textTertiary: Color(0xFF6E6E73),
    textDisabled: Color(0xFF48484A),
    textInverse: Color(0xFF1C1C1E),
    border: Color(0xFF38383A),
    separator: Color(0xFF38383A),
    overlay: Color(0xFF000000),
    scrim: Color(0xFF000000),
    link: Color(0xFF3D8BFF),
    focus: Color(0xFF3D8BFF),
    secondary: Color(0xFF9B9BA1),
    disabled: Color(0xFF3A3A3C),
    onDisabled: Color(0xFF6E6E73),
    overlayAlpha: 0.4,
  );

  static const highContrastColors = SyzygyColors(
    primary: Color(0xFF0047CC),
    onPrimary: Color(0xFFFFFFFF),
    primaryMuted: Color(0xFFCCDDFF),
    primarySubtle: Color(0xFFE5EEFF),
    error: Color(0xFFB71C1C),
    onError: Color(0xFFFFFFFF),
    errorMuted: Color(0xFFFFCDD2),
    destructive: Color(0xFFB71C1C),
    onDestructive: Color(0xFFFFFFFF),
    destructiveMuted: Color(0xFFFFCDD2),
    success: Color(0xFF1B5E20),
    onSuccess: Color(0xFFFFFFFF),
    successMuted: Color(0xFFC8E6C9),
    warning: Color(0xFFBF360C),
    onWarning: Color(0xFFFFFFFF),
    warningMuted: Color(0xFFFFE0B2),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF5F5F5),
    surfaceTertiary: Color(0xFFEEEEEE),
    onSurface: Color(0xFF000000),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF000000),
    textTertiary: Color(0xFF000000),
    textDisabled: Color(0xFF424242),
    textInverse: Color(0xFFFFFFFF),
    border: Color(0xFF000000),
    separator: Color(0xFF000000),
    overlay: Color(0xFF000000),
    scrim: Color(0xFF000000),
    link: Color(0xFF0047CC),
    focus: Color(0xFF0047CC),
    secondary: Color(0xFF424242),
    disabled: Color(0xFF9E9E9E),
    onDisabled: Color(0xFF616161),
    overlayAlpha: 0.6,
  );
}
