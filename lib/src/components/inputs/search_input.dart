import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A search field with a leading icon, trailing clear button, and built-in
/// debounce. Named `SearchInput` (not `SearchBar`) to avoid colliding with
/// Flutter Material's own `SearchBar`, and to match this library's
/// `TextInput`/`SecureInput` naming convention.
class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSearchTextChanged,
    this.debounce = const Duration(milliseconds: 300),
  
    this.theme,});

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSearchTextChanged;
  final Duration debounce;

  final SyzygyTheme? theme;
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onChanged?.call(value);
    if (widget.onSearchTextChanged == null) return;
    _timer?.cancel();
    _timer = Timer(widget.debounce, () => widget.onSearchTextChanged!(value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: TextField(
        controller: _controller,
        onChanged: _handleChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: theme.colors.surface,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return Semantics(
                button: true,
                label: 'Clear search',
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _handleChanged('');
                  },
                ),
              );
            },
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.radius.md),
            borderSide: BorderSide(color: theme.colors.border),
          ),
        ),
      ),
    );
  }
}
