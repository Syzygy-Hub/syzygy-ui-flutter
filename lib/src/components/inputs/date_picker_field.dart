import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A tappable field showing a formatted date, opening Flutter Material's
/// native [showDatePicker] when tapped.
class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.label,
    this.date,
    required this.onDateChange,
  
    this.theme,});

  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onDateChange;

  String _format(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _open(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: date ?? now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 100),
    );
    if (picked != null) onDateChange(picked);
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
                    date != null ? _format(date!) : 'Select date',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Icon(Icons.calendar_today_outlined, size: 20, color: theme.colors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
