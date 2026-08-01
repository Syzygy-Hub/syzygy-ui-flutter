import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A labeled dropdown / picker, selecting from a fixed list of options.
class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.optionTitle,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T) optionTitle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: DropdownButtonFormField<T>(
            value: value,
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
              fillColor: colors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: colors.border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
