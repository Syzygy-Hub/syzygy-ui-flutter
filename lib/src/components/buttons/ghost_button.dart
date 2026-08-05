import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A low-emphasis, text-only button with no fill or border.
class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.style,
    this.semanticLabel,
  
    this.theme,});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonStyle? style;
  final String? semanticLabel;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final disabled = onPressed == null;

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: SizedBox(
        height: theme.spacing.xxl,
        child: TextButton(
          onPressed: onPressed,
          style: style ??
              TextButton.styleFrom(
                foregroundColor: theme.colors.primary,
                disabledForegroundColor: theme.colors.onDisabled,
                minimumSize: const Size(48, 48),
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radius.md),
                ),
              ),
          child: Row(
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
