import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A filled, high-emphasis button for the primary action on a screen.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.style,
    this.semanticLabel,
  
    this.theme,});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final ButtonStyle? style;
  final String? semanticLabel;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final disabled = onPressed == null || isLoading;

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: SizedBox(
        height: theme.spacing.xxl,
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: style ??
              ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: theme.colors.onPrimary,
                disabledBackgroundColor: theme.colors.disabled,
                disabledForegroundColor: theme.colors.onDisabled,
                minimumSize: const Size(48, 48),
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radius.md),
                ),
              ),
          child: isLoading
              ? SizedBox(
                  height: theme.spacing.md,
                  width: theme.spacing.md,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colors.onPrimary),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18),
                      SizedBox(width: theme.spacing.sm),
                    ],
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
