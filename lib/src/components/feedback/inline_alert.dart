import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Variant styling for [InlineAlert].
enum AlertVariant { info, success, warning, error }

/// An inline status banner with 4 variants, using the `*Muted` color tokens
/// for background. Also known as `Banner` in other parts of the Syzygy
/// ecosystem — named `InlineAlert` here since Flutter Material already has
/// both a `Banner` widget (a diagonal corner ribbon, unrelated purpose) and
/// a `MaterialBanner` widget (closer in spirit but a full
/// `ScaffoldMessenger`-queued overlay, not an inline widget), and this
/// avoids colliding with either.
class InlineAlert extends StatelessWidget {
  const InlineAlert({super.key, required this.message, required this.variant,
    this.theme,});

  final String message;
  final AlertVariant variant;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    final (background, foreground, icon) = switch (variant) {
      AlertVariant.info => (theme.colors.primaryMuted, theme.colors.primary, Icons.info_outline),
      AlertVariant.success => (theme.colors.successMuted, theme.colors.success, Icons.check_circle_outline),
      AlertVariant.warning => (theme.colors.warningMuted, theme.colors.warning, Icons.warning_amber_outlined),
      AlertVariant.error => (theme.colors.destructiveMuted, theme.colors.error, Icons.error_outline),
    };

    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        padding: EdgeInsets.all(theme.spacing.sm),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(theme.radius.md),
        ),
        child: Row(
          children: [
            Icon(icon, color: foreground, size: 20),
            SizedBox(width: theme.spacing.sm),
            Expanded(
              child: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: foreground)),
            ),
          ],
        ),
      ),
    );
  }
}
