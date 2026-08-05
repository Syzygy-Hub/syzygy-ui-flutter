import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// An animated skeleton placeholder for list/table rows while content loads.
class ShimmerView extends StatefulWidget {
  const ShimmerView({super.key, this.height = 16,
    this.theme,});

  final double height;

  final SyzygyTheme? theme;
  @override
  State<ShimmerView> createState() => _ShimmerViewState();
}

class _ShimmerViewState extends State<ShimmerView> with SingleTickerProviderStateMixin {
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


    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: theme.colors.border.withValues(alpha: 0.3 + _controller.value * 0.4),
              borderRadius: BorderRadius.circular(theme.radius.sm),
            ),
          );
        },
      ),
    );
  }
}
