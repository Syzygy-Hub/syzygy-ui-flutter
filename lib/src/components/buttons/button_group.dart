import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A horizontal segmented row of buttons, supporting single-select
/// (default) or multi-select via [multiSelect]. [selection] is always a
/// list of selected indices — in single-select mode, callers are expected
/// to keep it constrained to at most one entry.
class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.options,
    required this.selection,
    required this.onSelectionChange,
    this.multiSelect = false,
  
    this.theme,});

  final List<String> options;
  final List<int> selection;
  final ValueChanged<List<int>> onSelectionChange;
  final bool multiSelect;

  void _handleTap(int index) {
    if (multiSelect) {
      final next = List<int>.from(selection);
      if (next.contains(index)) {
        next.remove(index);
      } else {
        next.add(index);
      }
      onSelectionChange(next);
    } else {
      onSelectionChange([index]);
    }
  }

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Container(
      padding: EdgeInsets.all(theme.spacing.xxs),
      decoration: BoxDecoration(
        color: theme.colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final selected = selection.contains(index);
          return Semantics(
            button: true,
            selected: selected,
            label: options[index],
            child: InkWell(
              onTap: () => _handleTap(index),
              borderRadius: BorderRadius.circular(theme.radius.sm),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: selected ? theme.colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(theme.radius.sm),
                ),
                child: Text(
                  options[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: selected ? theme.colors.onPrimary : theme.colors.onSurface,
                      ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
