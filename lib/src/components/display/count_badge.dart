import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A small numeric/dot badge meant to overlay an icon (e.g. a bell with an
/// unread count). Distinct from this library's own [Badge], which is a
/// standalone labeled pill.
class CountBadge extends StatelessWidget {
  const CountBadge({super.key, this.count, this.maxDisplayCount = 99,
    this.theme,});

  final int? count;
  final int maxDisplayCount;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    if (count != null && count! > 0) {
      final display = count! > maxDisplayCount ? '$maxDisplayCount+' : '$count';
      return Semantics(
        label: '$count unread',
        child: Container(
          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
          decoration: BoxDecoration(color: theme.colors.destructive, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            display,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: theme.colors.onDestructive),
          ),
        ),
      );
    }

    return Semantics(
      label: 'New',
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: theme.colors.destructive, shape: BoxShape.circle),
      ),
    );
  }
}
