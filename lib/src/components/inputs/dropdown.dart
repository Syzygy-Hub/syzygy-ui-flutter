import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A labeled dropdown / picker, selecting from a fixed list of options.
class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.optionTitle,
    this.theme,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T) optionTitle;
  final SyzygyTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: theme.colors.onSurface),
        ),
        SizedBox(height: theme.spacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: DropdownButtonFormField<T>(
            initialValue: value,
            items: options
                .map((option) => DropdownMenuItem<T>(
                      value: option,
                      child: Text(optionTitle(option)),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md,
                vertical: theme.spacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: theme.colors.border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
