import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
  
    this.theme,});

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
        child: Row(
          children: [
            if (leading != null) ...[leading!, SizedBox(width: theme.spacing.sm)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: theme.colors.onSurface)),
                  if (subtitle != null)
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.secondary)),
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
