import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// An expandable/collapsible section (accordion) with a tappable header.
class CollapsibleView extends StatefulWidget {
  const CollapsibleView({
    super.key,
    required this.title,
    this.initiallyExpanded = false,
    required this.child,
  });

  final String title;
  final bool initiallyExpanded;
  final Widget child;

  @override
  State<CollapsibleView> createState() => _CollapsibleViewState();
}

class _CollapsibleViewState extends State<CollapsibleView> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: '${widget.title}, ${_expanded ? 'expanded' : 'collapsed'}',
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSurface),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.expand_more, color: colors.secondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: widget.child,
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
