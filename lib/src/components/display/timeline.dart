import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// Where the dot/icon and connecting line sit relative to a [Timeline]
/// item's content.
enum TimelineItemAlignment { leading, trailing }

/// A single event in a [Timeline].
class TimelineItem {
  const TimelineItem({
    required this.title,
    this.subtitle,
    this.timestamp,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final String? timestamp;
  final IconData? icon;
}

/// A vertical list of events, each with a dot/icon on a connecting vertical
/// line, a title, and optional subtitle/timestamp. Also known as
/// `ActivityFeed` elsewhere in the Syzygy ecosystem.
///
/// The connecting line is drawn with simple fixed-height `Container`
/// segments stacked inside a `Column` of `Row`s, rather than a
/// `CustomPainter` measuring exact dot/text positions — this is a
/// working, not pixel-perfect, connector, which is the right tradeoff for
/// a component whose main job is "a list of things happened in order."
class Timeline extends StatelessWidget {
  const Timeline({
    super.key,
    required this.items,
    this.alignment = TimelineItemAlignment.leading,
    this.dotColor,
    this.lineColor,
  });

  final List<TimelineItem> items;
  final TimelineItemAlignment alignment;
  final Color? dotColor;
  final Color? lineColor;

  static const double _dotSize = 12;
  static const double _lineWidth = 2;
  static const double _segmentHeight = 32;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final dot = dotColor ?? colors.primary;
    final line = lineColor ?? colors.border;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++)
          _TimelineRow(
            item: items[i],
            alignment: alignment,
            dotColor: dot,
            lineColor: line,
            showConnector: i < items.length - 1,
            dotSize: _dotSize,
            lineWidth: _lineWidth,
            segmentHeight: _segmentHeight,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.item,
    required this.alignment,
    required this.dotColor,
    required this.lineColor,
    required this.showConnector,
    required this.dotSize,
    required this.lineWidth,
    required this.segmentHeight,
  });

  final TimelineItem item;
  final TimelineItemAlignment alignment;
  final Color dotColor;
  final Color lineColor;
  final bool showConnector;
  final double dotSize;
  final double lineWidth;
  final double segmentHeight;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final marker = Column(
      children: [
        item.icon != null
            ? Icon(item.icon, size: dotSize + 8, color: dotColor)
            : Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
        if (showConnector)
          Container(
            width: lineWidth,
            height: segmentHeight,
            color: lineColor,
          ),
      ],
    );

    final content = Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSurface)),
              if (item.timestamp != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(item.timestamp!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textTertiary)),
              ],
            ],
          ),
          if (item.subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(item.subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textTertiary)),
          ],
        ],
      ),
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: alignment == TimelineItemAlignment.leading
            ? [
                marker,
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: content),
              ]
            : [
                Expanded(child: content),
                const SizedBox(width: AppSpacing.sm),
                marker,
              ],
      ),
    );
  }
}
