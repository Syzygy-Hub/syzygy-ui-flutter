import 'package:flutter/material.dart';

import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';
import '../../theme/theme.dart';

/// A labeled dropdown / picker with an inline search field for filtering
/// the option list, selecting from a fixed list of options.
///
/// This is a standalone widget, not a wrapper around this library's
/// [Dropdown] — `Dropdown` renders via Flutter's own
/// `DropdownButtonFormField`, whose API has no hook for an inline search
/// field or a filtered, custom-rendered options list, so there's nothing
/// to compose. Instead, `SearchableDropdown` follows this library's own
/// anchored-overlay pattern already established by [Popover]: a
/// `CompositedTransformTarget`/`CompositedTransformFollower` pair (via an
/// `OverlayEntry`) anchors a `TextField` + filtered, tappable option list
/// beneath the field.
class SearchableDropdown<T> extends StatefulWidget {
  const SearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.optionTitle,
    this.hintText = 'Search...',
    this.theme,
  });

  final String label;
  final T? value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T) optionTitle;
  final String hintText;
  final SyzygyTheme? theme;

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final LayerLink _link = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _entry;
  List<T> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.options;
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    _searchController.dispose();
    super.dispose();
  }

  void _filter(String query) {
    setState(() {
      _filtered = widget.options
          .where((o) => widget.optionTitle(o).toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    _entry?.markNeedsBuild();
  }

  void _open() {
    if (_entry != null) return;
    final colors = SyzygyThemeProvider.of(context).colors;

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
            offset: const Offset(0, 56),
            targetAnchor: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 240, minWidth: 200),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: colors.border),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Semantics(
                          label: 'Search: ${widget.hintText}',
                          textField: true,
                          child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          onChanged: _filter,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: widget.hintText,
                            prefixIcon: const Icon(Icons.search, size: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                          ),
                        ),
                        ),
                      ),
                      Flexible(
                        child: Material(
                          color: Colors.transparent,
                          child: ListView(
                            shrinkWrap: true,
                            children: _filtered
                                .map((option) => Semantics(
                                      label: widget.optionTitle(option),
                                      button: true,
                                      child: ListTile(
                                      dense: true,
                                      title: Text(widget.optionTitle(option)),
                                      selected: option == widget.value,
                                      onTap: () {
                                        widget.onChanged(option);
                                        _dismiss();
                                      },
                                    )))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
    _searchController.clear();
    _filtered = widget.options;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


    return CompositedTransformTarget(
      link: _link,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: theme.colors.onSurface),
          ),
          SizedBox(height: theme.spacing.xs),
          InkWell(
            onTap: _open,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(theme.radius.md),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.value != null ? widget.optionTitle(widget.value as T) : widget.hintText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: theme.colors.onSurface),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: theme.colors.secondary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
