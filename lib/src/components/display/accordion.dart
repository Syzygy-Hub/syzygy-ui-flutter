import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// A single section within an [Accordion].
class AccordionSection {
  const AccordionSection({required this.title, required this.child});

  final String title;
  final Widget child;
}

/// A vertically stacked list of expandable/collapsible sections with a
/// tappable header per section, coordinating which section(s) are open.
///
/// Each section's expand/collapse animation mirrors this library's existing
/// [CollapsibleView] (an `AnimatedCrossFade` between a zero-height first
/// child and the section content), but the open/closed state is tracked
/// here as a group rather than reimplemented per-section, since `Accordion`
/// needs shared coordination (single-open-at-a-time by default) that a
/// standalone `CollapsibleView` doesn't have.
class Accordion extends StatefulWidget {
  const Accordion({
    super.key,
    required this.sections,
    this.allowMultipleOpen = false,
    this.initiallyOpenIndex,
  });

  final List<AccordionSection> sections;
  final bool allowMultipleOpen;
  final int? initiallyOpenIndex;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  late final Set<int> _openIndexes = widget.initiallyOpenIndex != null
      ? {widget.initiallyOpenIndex!}
      : <int>{};

  void _toggle(int index) {
    setState(() {
      final isOpen = _openIndexes.contains(index);
      if (widget.allowMultipleOpen) {
        if (isOpen) {
          _openIndexes.remove(index);
        } else {
          _openIndexes.add(index);
        }
      } else {
        _openIndexes
          ..clear()
          ..addAll(isOpen ? <int>{} : {index});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < widget.sections.length; i++) ...[
          if (i > 0) Divider(height: 1, thickness: 1, color: colors.border),
          _AccordionSectionView(
            section: widget.sections[i],
            expanded: _openIndexes.contains(i),
            onTap: () => _toggle(i),
          ),
        ],
      ],
    );
  }
}

class _AccordionSectionView extends StatelessWidget {
  const _AccordionSectionView({
    required this.section,
    required this.expanded,
    required this.onTap,
  });

  final AccordionSection section;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: '${section.title}, ${expanded ? 'expanded' : 'collapsed'}',
          child: InkWell(
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      section.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSurface),
                    ),
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
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
            child: section.child,
          ),
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
