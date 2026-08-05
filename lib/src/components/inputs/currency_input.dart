import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// Where the currency symbol renders relative to the numeric value.
enum CurrencySymbolPosition { prefix, suffix }

/// A numeric text field with a currency symbol prefix/suffix and
/// locale-aware thousands-separator grouping.
///
/// This deliberately does NOT depend on the `intl` package's `NumberFormat`.
/// `intl` is a genuinely new third-party (if Dart-team-maintained) pub.dev
/// dependency this library doesn't currently have — adding it would break
/// this package's advertised "zero third-party dependencies" claim
/// (`pubspec.yaml` description, README) for what a single component needs.
/// Instead, grouping/decimal formatting is hand-rolled from Dart core
/// (`num.toStringAsFixed` + manual thousands-separator insertion), which
/// covers the common case (fixed decimal places, `,`-grouped thousands)
/// this component needs without adding a dependency. If a consumer needs
/// full CLDR-correct locale formatting, they should format upstream with
/// `intl` themselves and pass the already-formatted text via [controller].
class CurrencyInput extends StatefulWidget {
  const CurrencyInput({
    super.key,
    this.label,
    this.controller,
    this.currencySymbol = '\$',
    this.symbolPosition = CurrencySymbolPosition.prefix,
    this.decimalDigits = 2,
    this.onChanged,
  
    this.theme,});

  final String? label;
  final TextEditingController? controller;
  final String currencySymbol;
  final CurrencySymbolPosition symbolPosition;
  final int decimalDigits;
  final ValueChanged<double>? onChanged;

  /// Inserts `,` thousands separators into the integer part of a
  /// fixed-decimal numeric string, e.g. "1234.5" -> "1,234.5".
  static String groupThousands(String numericString) {
    final parts = numericString.split('.');
    final buffer = StringBuffer();
    final intPart = parts[0];
    for (var i = 0; i < intPart.length; i++) {
      final remaining = intPart.length - i;
      if (i > 0 && remaining % 3 == 0) buffer.write(',');
      buffer.write(intPart[i]);
    }
    if (parts.length > 1) {
      buffer
        ..write('.')
        ..write(parts[1]);
    }
    return buffer.toString();
  }

  final SyzygyTheme? theme;
  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String text) {
    final parsed = double.tryParse(text.replaceAll(',', ''));
    if (parsed != null) widget.onChanged?.call(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);

    final symbolText = Text(
      widget.currencySymbol,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: theme.colors.textTertiary),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: theme.colors.onSurface)),
          SizedBox(height: theme.spacing.xs),
        ],
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(decimal: widget.decimalDigits > 0),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
            onChanged: _handleChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.surface,
              prefixIcon: widget.symbolPosition == CurrencySymbolPosition.prefix
                  ? Padding(padding: EdgeInsets.only(left: theme.spacing.md), child: symbolText)
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: widget.symbolPosition == CurrencySymbolPosition.suffix
                  ? Padding(padding: EdgeInsets.only(right: theme.spacing.md), child: symbolText)
                  : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: theme.colors.border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
