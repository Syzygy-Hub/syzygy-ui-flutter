import 'package:flutter/material.dart' hide Chip;

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../display/chip.dart';

/// A text input that renders entered items as dismissible [Chip] widgets.
/// Typing a value and pressing enter/submit adds it to [tags].
class TagInput extends StatefulWidget {
  const TagInput({
    super.key,
    required this.tags,
    required this.onTagsChange,
    this.hintText,
  });

  final List<String> tags;
  final ValueChanged<List<String>> onTagsChange;
  final String? hintText;

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    widget.onTagsChange([...widget.tags, trimmed]);
    _controller.clear();
  }

  void _removeTag(int index) {
    final next = List<String>.from(widget.tags)..removeAt(index);
    widget.onTagsChange(next);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (var i = 0; i < widget.tags.length; i++)
            Chip(text: widget.tags[i], onRemove: () => _removeTag(i)),
          SizedBox(
            width: 120,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: widget.hintText ?? 'Add tag',
              ),
              onSubmitted: _addTag,
            ),
          ),
        ],
      ),
    );
  }
}
