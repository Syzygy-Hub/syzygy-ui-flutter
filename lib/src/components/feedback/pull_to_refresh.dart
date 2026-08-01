import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A scrollable container with native pull-to-refresh wired to a refresh
/// handler, wrapping [RefreshIndicator].
class PullToRefresh extends StatelessWidget {
  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: colors.primary,
      child: child,
    );
  }
}
