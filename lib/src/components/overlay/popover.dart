import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// An anchored floating content bubble, triggered by tapping [child].
///
/// Flutter doesn't ship a single native "popover" widget the way SwiftUI
/// does, but does provide `CompositedTransformTarget`/
/// `CompositedTransformFollower` as the built-in anchored-overlay
/// primitive — this widget uses that (via an [OverlayEntry]) rather than
/// reimplementing anchor positioning math by hand.
class Popover extends StatefulWidget {
  const Popover({super.key, required this.child, required this.content});

  final Widget child;
  final Widget content;

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _toggle() {
    if (_entry != null) {
      _dismiss();
    } else {
      _show();
    }
  }

  void _show() {
    final colors = AppColors.of(context);
    _entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _dismiss,
            ),
          ),
          CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            offset: const Offset(0, 8),
            targetAnchor: Alignment.bottomLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: colors.border),
                ),
                child: widget.content,
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_entry!);
    setState(() {});
  }

  void _dismiss() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(onTap: _toggle, child: widget.child),
    );
  }
}
