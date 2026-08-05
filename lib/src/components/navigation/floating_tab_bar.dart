import 'package:flutter/material.dart';

import 'tab_bar_item.dart';
import '../../theme/theme.dart';

/// A floating, pill-style bottom bar showing BOTH icon AND label per item.
///
/// This fills a genuine gap rather than duplicating existing navigation
/// components: `TabBar` is edge-to-edge + labeled, `BottomNavigationBar` is
/// floating + icon-only (see its own doc comment). That leaves
/// floating + icon-and-label as the one combination in the 2x2 matrix
/// without a component — `FloatingTabBar` is that combination.
class FloatingTabBar<T> extends StatelessWidget {
  const FloatingTabBar({
    super.key,
    required this.items,
    required this.selection,
    required this.onSelectionChange,
    this.theme,
  });

  final List<TabBarItem<T>> items;
  final T selection;
  final ValueChanged<T> onSelectionChange;
  final SyzygyTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Container(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xs),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radius.full),
        boxShadow: [
          BoxShadow(color: theme.colors.overlay, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final selected = item.tag == selection;
          return Semantics(
            button: true,
            selected: selected,
            label: item.label,
            child: InkWell(
              onTap: () => onSelectionChange(item.tag),
              borderRadius: BorderRadius.circular(theme.radius.full),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, color: selected ? theme.colors.primary : theme.colors.secondary, size: 20),
                    SizedBox(height: theme.spacing.xxs),
                    Text(
                      item.label,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: selected ? theme.colors.primary : theme.colors.secondary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
