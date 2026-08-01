import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// An inline, single-row segmented picker for switching between a small set
/// of content states — distinct from `TabBar`/`BottomNavigationBar`, which
/// are for primary app navigation.
class SegmentedControl<T> extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.options,
    required this.selection,
    required this.onChanged,
    required this.optionTitle,
  });

  final List<T> options;
  final T selection;
  final ValueChanged<T> onChanged;
  final String Function(T) optionTitle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SegmentedButton<T>(
      segments: options
          .map((option) => ButtonSegment<T>(value: option, label: Text(optionTitle(option))))
          .toList(),
      selected: {selection},
      onSelectionChanged: (values) => onChanged(values.first),
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: colors.primary,
        selectedForegroundColor: colors.onPrimary,
      ),
    );
  }
}
