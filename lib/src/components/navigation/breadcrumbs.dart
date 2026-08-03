import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// A single tappable label in a [Breadcrumbs] trail.
class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;
}

/// A horizontal trail of tappable navigation labels separated by a
/// separator glyph, using the [AppColors.separator] color token.
class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key, required this.items});

  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(width: AppSpacing.xxs),
            Text('/', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.separator)),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Semantics(
            button: items[i].onTap != null,
            label: items[i].label,
            child: InkWell(
              onTap: items[i].onTap,
              child: Text(
                items[i].label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: items[i].onTap != null ? colors.link : colors.textTertiary,
                    ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
