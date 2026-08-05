import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A labeled on/off toggle, wrapping Flutter Material's own [Switch].
class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
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
      toggled: value,
      label: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Switch(value: value, onChanged: onChanged, activeThumbColor: theme.colors.primary),
        ],
      ),
    );
  }
}
