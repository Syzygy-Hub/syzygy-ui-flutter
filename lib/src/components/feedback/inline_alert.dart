import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

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
  const InlineAlert({super.key, required this.message, required this.variant});

  final String message;
  final AlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final (background, foreground, icon) = switch (variant) {
      AlertVariant.info => (colors.primaryMuted, colors.primary, Icons.info_outline),
      AlertVariant.success => (colors.successMuted, colors.success, Icons.check_circle_outline),
      AlertVariant.warning => (colors.warningMuted, colors.warning, Icons.warning_amber_outlined),
      AlertVariant.error => (colors.destructiveMuted, colors.error, Icons.error_outline),
    };

    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(icon, color: foreground, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: foreground)),
            ),
          ],
        ),
      ),
    );
  }
}
