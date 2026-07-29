import 'package:flutter/material.dart';

/// Semantic color tokens for light mode.
class AppColorsLight {
  AppColorsLight._();

  static const Color primary = Color(0xFF2563EB);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF64748B);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color destructive = Color(0xFFDC2626);
  static const Color onDestructive = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF16A34A);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFD97706);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFDC2626);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF0F172A);
  static const Color background = Color(0xFFF8FAFC);
  static const Color onBackground = Color(0xFF0F172A);
  static const Color border = Color(0xFFE2E8F0);
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color onDisabled = Color(0xFF94A3B8);
}

/// Semantic color tokens for dark mode.
class AppColorsDark {
  AppColorsDark._();

  static const Color primary = Color(0xFF3B82F6);
  static const Color onPrimary = Color(0xFF0B1220);
  static const Color secondary = Color(0xFF94A3B8);
  static const Color onSecondary = Color(0xFF0B1220);
  static const Color destructive = Color(0xFFF87171);
  static const Color onDestructive = Color(0xFF0B1220);
  static const Color success = Color(0xFF4ADE80);
  static const Color onSuccess = Color(0xFF0B1220);
  static const Color warning = Color(0xFFFBBF24);
  static const Color onWarning = Color(0xFF0B1220);
  static const Color error = Color(0xFFF87171);
  static const Color onError = Color(0xFF0B1220);
  static const Color surface = Color(0xFF1E293B);
  static const Color onSurface = Color(0xFFF1F5F9);
  static const Color background = Color(0xFF0F172A);
  static const Color onBackground = Color(0xFFF1F5F9);
  static const Color border = Color(0xFF334155);
  static const Color disabled = Color(0xFF334155);
  static const Color onDisabled = Color(0xFF64748B);
}

/// [ThemeExtension] exposing semantic color tokens through [Theme.of].
///
/// Register light/dark instances via [ThemeData.extensions] so components
/// can read tokens without depending on [Brightness] branching directly.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.destructive,
    required this.onDestructive,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.error,
    required this.onError,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.border,
    required this.disabled,
    required this.onDisabled,
  });

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color destructive;
  final Color onDestructive;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color error;
  final Color onError;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color border;
  final Color disabled;
  final Color onDisabled;

  static const AppColors light = AppColors(
    primary: AppColorsLight.primary,
    onPrimary: AppColorsLight.onPrimary,
    secondary: AppColorsLight.secondary,
    onSecondary: AppColorsLight.onSecondary,
    destructive: AppColorsLight.destructive,
    onDestructive: AppColorsLight.onDestructive,
    success: AppColorsLight.success,
    onSuccess: AppColorsLight.onSuccess,
    warning: AppColorsLight.warning,
    onWarning: AppColorsLight.onWarning,
    error: AppColorsLight.error,
    onError: AppColorsLight.onError,
    surface: AppColorsLight.surface,
    onSurface: AppColorsLight.onSurface,
    background: AppColorsLight.background,
    onBackground: AppColorsLight.onBackground,
    border: AppColorsLight.border,
    disabled: AppColorsLight.disabled,
    onDisabled: AppColorsLight.onDisabled,
  );

  static const AppColors dark = AppColors(
    primary: AppColorsDark.primary,
    onPrimary: AppColorsDark.onPrimary,
    secondary: AppColorsDark.secondary,
    onSecondary: AppColorsDark.onSecondary,
    destructive: AppColorsDark.destructive,
    onDestructive: AppColorsDark.onDestructive,
    success: AppColorsDark.success,
    onSuccess: AppColorsDark.onSuccess,
    warning: AppColorsDark.warning,
    onWarning: AppColorsDark.onWarning,
    error: AppColorsDark.error,
    onError: AppColorsDark.onError,
    surface: AppColorsDark.surface,
    onSurface: AppColorsDark.onSurface,
    background: AppColorsDark.background,
    onBackground: AppColorsDark.onBackground,
    border: AppColorsDark.border,
    disabled: AppColorsDark.disabled,
    onDisabled: AppColorsDark.onDisabled,
  );

  /// Resolves the current [AppColors] from [context], falling back to
  /// brightness-derived defaults if no [ThemeExtension] was registered.
  static AppColors of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppColors>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? destructive,
    Color? onDestructive,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? error,
    Color? onError,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? onBackground,
    Color? border,
    Color? disabled,
    Color? onDisabled,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      destructive: destructive ?? this.destructive,
      onDestructive: onDestructive ?? this.onDestructive,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      border: border ?? this.border,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      onDestructive: Color.lerp(onDestructive, other.onDestructive, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t)!,
    );
  }
}

/// Convenience [ThemeData] builders that register [AppColors] tokens.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsLight.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColorsLight.background,
      extensions: const [AppColors.light],
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsDark.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColorsDark.background,
      extensions: const [AppColors.dark],
    );
  }
}
