import 'package:flutter/material.dart' hide BottomNavigationBar;

import 'tab_bar_item.dart';
import '../../theme/theme.dart';

/// A floating, icon-only bottom navigation pill — a visual alternative to
/// `TabBar` for screens that want a compact, inset navigation surface.
/// Hides Flutter Material's own `BottomNavigationBar` so this library can
/// keep the friendly name — the same convention already used by [Badge].
class BottomNavigationBar<T> extends StatelessWidget {
  const BottomNavigationBar({
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


    return Container(
      padding: EdgeInsets.all(theme.spacing.xs),
      decoration: BoxDecoration(color: theme.colors.surface, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final selected = item.tag == selection;
          return Semantics(
            button: true,
            selected: selected,
            label: item.label,
            child: InkWell(
              onTap: () => onSelectionChanged(item.tag),
              customBorder: const CircleBorder(),
              child: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? theme.colors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: selected ? theme.colors.onPrimary : theme.colors.secondary),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
