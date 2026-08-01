import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A labeled on/off toggle, wrapping Flutter Material's own [Switch].
class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      toggled: value,
      label: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Switch(value: value, onChanged: onChanged, activeThumbColor: colors.primary),
        ],
      ),
    );
  }
}
