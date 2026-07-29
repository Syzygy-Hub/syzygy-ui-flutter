import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

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
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonStyle? style;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final disabled = onPressed == null;

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: SizedBox(
        height: AppSpacing.xxl,
        child: OutlinedButton(
          onPressed: onPressed,
          style: style ??
              OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                disabledForegroundColor: colors.onDisabled,
                side: BorderSide(
                  color: disabled ? colors.disabled : colors.primary,
                ),
                minimumSize: const Size(48, 48),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
