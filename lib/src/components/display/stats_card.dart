import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
  
    this.theme,});

  final String label;
  final String value;
  final TrendDirection? trend;
  final String? trendValue;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    final trendColor = switch (trend) {
      TrendDirection.up => theme.colors.success,
      TrendDirection.down => theme.colors.error,
      TrendDirection.neutral => theme.colors.textTertiary,
      null => theme.colors.textTertiary,
    };
    final trendIcon = switch (trend) {
      TrendDirection.up => Icons.arrow_upward,
      TrendDirection.down => Icons.arrow_downward,
      TrendDirection.neutral => Icons.remove,
      null => null,
    };

    return Container(
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radius.md),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.textTertiary)),
          SizedBox(height: theme.spacing.xxs),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: theme.colors.onSurface)),
          if (trend != null && trendValue != null) ...[
            SizedBox(height: theme.spacing.xxs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(trendIcon, size: 14, color: trendColor),
                SizedBox(width: theme.spacing.xxs),
                Text(trendValue!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: trendColor)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
