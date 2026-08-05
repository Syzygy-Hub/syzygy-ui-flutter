import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A row of dots indicating the current page position, syncing with
/// [PagerView]'s `onPageChanged` callback. Also known as `DotIndicator`
/// elsewhere in the Syzygy ecosystem.
///
/// This is a read-only display component — it does not support tap-to-
/// navigate. That matches the nature of a page indicator (it reflects
/// [PagerView]'s state, it doesn't drive it); a consumer that wants
/// tap-to-navigate can wrap a dot in their own `GestureDetector` and call
/// their `PageController` directly, but that's deliberately left out of
/// this component to keep it a simple, dumb display widget.
class PageControl extends StatelessWidget {
  const PageControl({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.activeColor,
    this.inactiveColor,
  
    this.theme,});

  final int pageCount;
  final int currentPage;
  final Color? activeColor;
  final Color? inactiveColor;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final active = activeColor ?? theme.colors.primary;
    final inactive = inactiveColor ?? theme.colors.disabled;

    return Semantics(
      label: 'Page ${currentPage + 1} of $pageCount',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.xxs),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? active : inactive,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}
