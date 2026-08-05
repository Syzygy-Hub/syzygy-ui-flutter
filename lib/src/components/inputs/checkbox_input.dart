import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A labeled checkbox. Named `CheckboxInput` (not `Checkbox`) to avoid
/// colliding with Flutter Material's own [Checkbox].
class CheckboxInput extends StatelessWidget {
  const CheckboxInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  
    this.theme,});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      checked: value,
      label: label,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: value, onChanged: (v) => onChanged(v ?? false), activeColor: theme.colors.primary),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
