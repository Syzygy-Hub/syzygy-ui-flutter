import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

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
  });

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

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.md),
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
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: selected ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  options[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: selected ? colors.onPrimary : colors.onSurface,
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
