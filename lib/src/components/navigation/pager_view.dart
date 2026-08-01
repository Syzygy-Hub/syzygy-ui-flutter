import 'package:flutter/material.dart';

/// Swipeable, paged content — e.g. onboarding screens or an image carousel.
/// Distinct from `TabBar`, which is navigation chrome; this has no chrome of
/// its own, just paged content via [PageView]. Note: Flutter's own widget is
/// named `PageView`, not `PagerView`, so there is no naming collision here.
class PagerView extends StatelessWidget {
  const PagerView({
    super.key,
    required this.children,
    this.controller,
    this.onPageChanged,
  });

  final List<Widget> children;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: children,
    );
  }
}
