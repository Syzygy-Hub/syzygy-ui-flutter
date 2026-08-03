import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// Trend direction for [StatsCard].
enum TrendDirection { up, down, neutral }

/// A card showing a label, a large value, and an optional trend indicator
/// (up/down/neutral icon + delta text, e.g. "+12%"). Also known as
/// `MetricCard` in other parts of the Syzygy ecosystem.
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    this.trend,
    this.trendValue,
  });

  final String label;
  final String value;
  final TrendDirection? trend;
  final String? trendValue;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final trendColor = switch (trend) {
      TrendDirection.up => colors.success,
      TrendDirection.down => colors.error,
      TrendDirection.neutral => colors.textTertiary,
      null => colors.textTertiary,
    };
    final trendIcon = switch (trend) {
      TrendDirection.up => Icons.arrow_upward,
      TrendDirection.down => Icons.arrow_downward,
      TrendDirection.neutral => Icons.remove,
      null => null,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textTertiary)),
          const SizedBox(height: AppSpacing.xxs),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: colors.onSurface)),
          if (trend != null && trendValue != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(trendIcon, size: 14, color: trendColor),
                const SizedBox(width: AppSpacing.xxs),
                Text(trendValue!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: trendColor)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
