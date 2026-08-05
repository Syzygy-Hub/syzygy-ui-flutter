import 'package:flutter/material.dart' hide TabBar;

import 'tab_bar_item.dart';
import '../../theme/theme.dart';

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
    this.theme,
  });

  final List<TabBarItem<T>> items;
  final T selection;
  final ValueChanged<T> onSelectionChanged;
  final SyzygyTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border(top: BorderSide(color: theme.colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: items.map((item) {
            final selected = item.tag == selection;
            final color = selected ? theme.colors.primary : theme.colors.secondary;
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
