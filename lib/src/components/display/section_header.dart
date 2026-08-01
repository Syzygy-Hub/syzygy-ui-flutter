import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// A section title with an optional trailing text action (e.g. "See All").
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionPressed,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      header: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSurface),
              ),
              if (actionLabel != null && onActionPressed != null)
                TextButton(
                  onPressed: onActionPressed,
                  child: Text(actionLabel!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
