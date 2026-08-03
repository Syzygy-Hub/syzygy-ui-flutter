import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A tappable field showing a formatted date, opening Flutter Material's
/// native [showDatePicker] when tapped.
class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.label,
    this.date,
    required this.onDateChange,
  });

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
                    date != null ? _format(date!) : 'Select date',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Icon(Icons.calendar_today_outlined, size: 20, color: colors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
