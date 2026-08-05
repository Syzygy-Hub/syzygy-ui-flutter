import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A scrollable container with native pull-to-refresh wired to a refresh
/// handler, wrapping [RefreshIndicator].
class PullToRefresh extends StatelessWidget {
  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  
    this.theme,});

  final Future<void> Function() onRefresh;
  final Widget child;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return RefreshIndicator(
      onRefresh: onRefresh,
      color: theme.colors.primary,
      child: child,
    );
  }
}
