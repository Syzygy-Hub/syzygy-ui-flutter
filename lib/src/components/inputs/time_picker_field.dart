import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A tappable field showing a formatted time, opening Flutter Material's
/// native [showTimePicker] when tapped.
class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.label,
    this.time,
    required this.onTimeChange,
  });

  final String label;
  final TimeOfDay? time;
  final ValueChanged<TimeOfDay> onTimeChange;

  Future<void> _open(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
    );
    if (picked != null) onTimeChange(picked);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.textTertiary)),
                  Text(
                    time != null ? time!.format(context) : 'Select time',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Icon(Icons.access_time_outlined, size: 20, color: colors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
