import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A labeled slider with a live value readout, wrapping Flutter Material's
/// own [Slider]. Named `SliderInput` (not `Slider`) to avoid colliding with
/// it.
class SliderInput extends StatelessWidget {
  const SliderInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
  
    this.theme,});

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int? divisions;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value.toStringAsFixed(2), style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Semantics(
          slider: true,
          label: label,
          value: value.toStringAsFixed(2),
          child: Slider(
            value: value,
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: theme.colors.primary,
          ),
        ),
      ],
    );
  }
}
