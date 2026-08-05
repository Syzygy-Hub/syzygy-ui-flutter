import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A medium-emphasis outlined button, typically paired with a
/// [PrimaryButton] for secondary actions.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
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
        child: OutlinedButton(
          onPressed: onPressed,
          style: style ??
              OutlinedButton.styleFrom(
                foregroundColor: theme.colors.primary,
                disabledForegroundColor: theme.colors.onDisabled,
                side: BorderSide(
                  color: disabled ? theme.colors.disabled : theme.colors.primary,
                ),
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
