import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// A styled, optionally-tappable row wrapper with a leading slot, title,
/// subtitle, and a trailing accessory slot.
class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.sm)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.onSurface)),
                  if (subtitle != null)
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.secondary)),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );

    return Semantics(
      label: subtitle == null ? title : '$title, $subtitle',
      button: onTap != null,
      child: onTap == null ? row : InkWell(onTap: onTap, child: row),
    );
  }
}
