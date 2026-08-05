import 'package:flutter/material.dart' hide Badge;

import '../../theme/theme.dart';

/// Semantic variants for [Badge].
enum BadgeVariant { primary, success, warning, error }

/// A filled pill badge used for status labels and tags.
class Badge extends StatelessWidget {
  const Badge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.decoration,
  
    this.theme,});

  final String text;
  final BadgeVariant variant;
  final BoxDecoration? decoration;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final (background, foreground) = switch (variant) {
      BadgeVariant.primary => (theme.colors.primary, theme.colors.onPrimary),
      BadgeVariant.success => (theme.colors.success, theme.colors.onSuccess),
      BadgeVariant.warning => (theme.colors.warning, theme.colors.onWarning),
      BadgeVariant.error => (theme.colors.error, theme.colors.onError),
    };

    return Semantics(
      label: text,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.sm,
          vertical: theme.spacing.xs,
        ),
        decoration: decoration ??
            BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(theme.radius.full),
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
