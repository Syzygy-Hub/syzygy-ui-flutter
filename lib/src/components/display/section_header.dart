import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A section title with an optional trailing text action (e.g. "See All").
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionPressed,
  
    this.theme,});

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      header: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 32),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: theme.colors.onSurface),
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
