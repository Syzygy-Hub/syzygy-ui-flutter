import 'package:flutter/material.dart' hide Badge;

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// Semantic variants for [Badge].
enum BadgeVariant { primary, success, warning, error }

/// A filled pill badge used for status labels and tags.
class Badge extends StatelessWidget {
  const Badge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.decoration,
  });

  final String text;
  final BadgeVariant variant;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (background, foreground) = switch (variant) {
      BadgeVariant.primary => (colors.primary, colors.onPrimary),
      BadgeVariant.success => (colors.success, colors.onSuccess),
      BadgeVariant.warning => (colors.warning, colors.onWarning),
      BadgeVariant.error => (colors.error, colors.onError),
    };

    return Semantics(
      label: text,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: decoration ??
            BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
