import 'package:flutter/material.dart' hide TabBar;

import '../../tokens/colors.dart';
import 'tab_bar_item.dart';

/// An edge-to-edge, icon-and-label tab bar. Presentational only — pass
/// [selection]/[onSelectionChanged] rather than a `TabController`. Hides
/// Flutter Material's own `TabBar` so this library can keep the friendly
/// `TabBar` name — the same convention already used by [Badge].
class TabBar<T> extends StatelessWidget {
  const TabBar({
    super.key,
    required this.items,
    required this.selection,
    required this.onSelectionChanged,
  });

  final List<TabBarItem<T>> items;
  final T selection;
  final ValueChanged<T> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: items.map((item) {
            final selected = item.tag == selection;
            final color = selected ? colors.primary : colors.secondary;
            return Expanded(
              child: Semantics(
                button: true,
                selected: selected,
                label: item.label,
                child: InkWell(
                  onTap: () => onSelectionChanged(item.tag),
                  child: SizedBox(
                    height: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, color: color, size: 22),
                        Text(item.label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
