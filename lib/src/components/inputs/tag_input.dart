import 'package:flutter/material.dart' hide Chip;

import '../display/chip.dart';
import '../../theme/theme.dart';

/// A text input that renders entered items as dismissible [Chip] widgets.
/// Typing a value and pressing enter/submit adds it to [tags].
class TagInput extends StatefulWidget {
  const TagInput({
    super.key,
    required this.tags,
    required this.onTagsChange,
    this.hintText,
  
    this.theme,});

  final List<String> tags;
  final ValueChanged<List<String>> onTagsChange;
  final String? hintText;

  final SyzygyTheme? theme;
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
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


    return Container(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xs),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: theme.spacing.xs,
        runSpacing: theme.spacing.xs,
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
