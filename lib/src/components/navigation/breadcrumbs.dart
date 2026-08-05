import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../theme/theme.dart';

/// A single tappable label in a [Breadcrumbs] trail.
class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;
}

/// A horizontal trail of tappable navigation labels separated by a
/// separator glyph, using the [AppColors.separator] color token.
class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key, required this.items,
    this.theme,});

  final List<BreadcrumbItem> items;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) ...[
            SizedBox(width: theme.spacing.xxs),
            Text('/', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.separator)),
            SizedBox(width: theme.spacing.xxs),
          ],
          Semantics(
            button: items[i].onTap != null,
            label: items[i].label,
            child: InkWell(
              onTap: items[i].onTap,
              child: Text(
                items[i].label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: items[i].onTap != null ? theme.colors.link : theme.colors.textTertiary,
                    ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
