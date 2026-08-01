import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A single labeled radio option. Compose several with shared parent state
/// to build a radio group. Named `RadioButtonInput` for cross-platform
/// naming consistency across the Syzygy ecosystem.
class RadioButtonInput<T> extends StatelessWidget {
  const RadioButtonInput({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final selected = value == groupValue;

    return Semantics(
      selected: selected,
      label: label,
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: (v) => onChanged(v as T),
              activeColor: colors.primary,
            ),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
