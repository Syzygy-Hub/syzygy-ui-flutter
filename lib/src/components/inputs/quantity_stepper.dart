import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A +/- quantity control, bounded to [min]/[max].
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 99,
    this.step = 1,
  
    this.theme,});

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final int step;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final atMin = value <= min;
    final atMax = value >= max;

    return Semantics(
      label: 'Quantity: $value',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(theme.radius.md),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Decrease',
              onPressed: atMin ? null : () => onChanged((value - step).clamp(min, max)),
              icon: const Icon(Icons.remove),
              color: theme.colors.primary,
            ),
            SizedBox(
              width: 24,
              child: Text('$value', textAlign: TextAlign.center),
            ),
            IconButton(
              tooltip: 'Increase',
              onPressed: atMax ? null : () => onChanged((value + step).clamp(min, max)),
              icon: const Icon(Icons.add),
              color: theme.colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
