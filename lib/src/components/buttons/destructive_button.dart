import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A filled button that signals a destructive or irreversible action,
/// such as delete or remove.
class DestructiveButton extends StatelessWidget {
  const DestructiveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.style,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final ButtonStyle? style;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final disabled = onPressed == null || isLoading;

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: SizedBox(
        height: AppSpacing.xxl,
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: style ??
              ElevatedButton.styleFrom(
                backgroundColor: colors.destructive,
                foregroundColor: colors.onDestructive,
                disabledBackgroundColor: colors.disabled,
                disabledForegroundColor: colors.onDisabled,
                minimumSize: const Size(48, 48),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
          child: isLoading
              ? SizedBox(
                  height: AppSpacing.md,
                  width: AppSpacing.md,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(colors.onDestructive),
                  ),
                )
              : Row(
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
