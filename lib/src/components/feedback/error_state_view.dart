import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../buttons/primary_button.dart';

/// An icon, title, subtitle, and retry action for error states. Mirrors
/// [EmptyStateView]'s structure with a destructive-tinted icon and a
/// mandatory retry action.
class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.title,
    this.subtitle,
    this.retryLabel = 'Retry',
    required this.onRetryPressed,
    this.icon = Icons.error_outline,
  });

  final String title;
  final String? subtitle;
  final String retryLabel;
  final VoidCallback onRetryPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      label: subtitle == null ? title : '$title. $subtitle',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colors.destructive),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSurface),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.secondary),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(label: retryLabel, onPressed: onRetryPressed),
          ],
        ),
      ),
    );
  }
}
