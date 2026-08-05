import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// An expandable/collapsible section (accordion) with a tappable header.
class CollapsibleView extends StatefulWidget {
  const CollapsibleView({
    super.key,
    required this.title,
    this.initiallyExpanded = false,
    required this.child,
  
    this.theme,});

  final String title;
  final bool initiallyExpanded;
  final Widget child;

  final SyzygyTheme? theme;
  @override
  State<CollapsibleView> createState() => _CollapsibleViewState();
}

class _CollapsibleViewState extends State<CollapsibleView> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


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
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: theme.colors.onSurface),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.expand_more, color: theme.colors.secondary),
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
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
            child: widget.child,
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
