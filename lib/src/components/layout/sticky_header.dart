import 'package:flutter/material.dart';

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({required this.child, required this.height});

  final Widget child;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}

/// A scrollable [child] with a [header] that stays pinned to the top while
/// scrolling. Implemented with `CustomScrollView` + `SliverPersistentHeader`
/// — Flutter's own native mechanism for sticky headers — rather than a
/// manual scroll-offset approach.
class StickyHeader extends StatelessWidget {
  const StickyHeader({
    super.key,
    required this.header,
    required this.child,
    this.headerHeight = kToolbarHeight,
  });

  final Widget header;
  final Widget child;
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(child: header, height: headerHeight),
        ),
        SliverToBoxAdapter(child: child),
      ],
    );
  }
}
