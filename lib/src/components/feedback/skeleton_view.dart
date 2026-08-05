import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Shape options for [SkeletonView].
enum SkeletonShape { rectangle, circle }

/// An animated shimmer placeholder, parameterized by [shape] and
/// [width]/[height]. Mirrors [ShimmerView]'s shimmer animation
/// implementation, generalized to circle shapes for avatar-style
/// placeholders in addition to rectangular rows.
class SkeletonView extends StatefulWidget {
  const SkeletonView({
    super.key,
    this.shape = SkeletonShape.rectangle,
    this.width,
    this.height = 16,
    this.borderRadius,
  
    this.theme,});

  final SkeletonShape shape;
  final double? width;
  final double height;
  final double? borderRadius;

  final SyzygyTheme? theme;
  @override
  State<SkeletonView> createState() => _SkeletonViewState();
}

class _SkeletonViewState extends State<SkeletonView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);

    final isCircle = widget.shape == SkeletonShape.circle;

    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: widget.width ?? (isCircle ? widget.height : null),
            height: widget.height,
            decoration: BoxDecoration(
              color: theme.colors.border.withValues(alpha: 0.3 + _controller.value * 0.4),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle
                  ? null
                  : BorderRadius.circular(widget.borderRadius ?? theme.radius.sm),
            ),
          );
        },
      ),
    );
  }
}
