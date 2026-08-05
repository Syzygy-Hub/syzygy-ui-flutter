import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A tappable field showing a formatted time, opening Flutter Material's
/// native [showTimePicker] when tapped.
class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.label,
    this.time,
    required this.onTimeChange,
  
    this.theme,});

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

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(theme.radius.md),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            border: Border.all(color: theme.colors.border),
            borderRadius: BorderRadius.circular(theme.radius.md),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: theme.colors.textTertiary)),
                  Text(
                    time != null ? time!.format(context) : 'Select time',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Icon(Icons.access_time_outlined, size: 20, color: theme.colors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
