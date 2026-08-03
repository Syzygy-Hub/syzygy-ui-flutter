import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';
import 'tab_bar_item.dart';

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
  });

  final List<TabBarItem<T>> items;
  final T selection;
  final ValueChanged<T> onSelectionChange;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(color: colors.overlay, blurRadius: 8, offset: const Offset(0, 2)),
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
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, color: selected ? colors.primary : colors.secondary, size: 20),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      item.label,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: selected ? colors.primary : colors.secondary,
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
