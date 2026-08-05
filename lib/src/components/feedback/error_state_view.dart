import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import '../../theme/theme.dart';

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
  
    this.theme,});

  final String title;
  final String? subtitle;
  final String retryLabel;
  final VoidCallback onRetryPressed;
  final IconData icon;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: subtitle == null ? title : '$title. $subtitle',
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colors.destructive),
            SizedBox(height: theme.spacing.md),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: theme.colors.onSurface),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: theme.spacing.xs),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: theme.colors.secondary),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: theme.spacing.lg),
            PrimaryButton(label: retryLabel, onPressed: onRetryPressed),
          ],
        ),
      ),
    );
  }
}
