import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';

/// A +/- quantity control, bounded to [min]/[max].
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 99,
    this.step = 1,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final int step;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final atMin = value <= min;
    final atMax = value >= max;

    return Semantics(
      label: 'Quantity: $value',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Decrease',
              onPressed: atMin ? null : () => onChanged((value - step).clamp(min, max)),
              icon: const Icon(Icons.remove),
              color: colors.primary,
            ),
            SizedBox(
              width: 24,
              child: Text('$value', textAlign: TextAlign.center),
            ),
            IconButton(
              tooltip: 'Increase',
              onPressed: atMax ? null : () => onChanged((value + step).clamp(min, max)),
              icon: const Icon(Icons.add),
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
