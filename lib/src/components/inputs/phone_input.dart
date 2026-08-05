import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// A single selectable country entry for [PhoneInput].
class PhoneCountry {
  const PhoneCountry({required this.flagEmoji, required this.dialCode, required this.name});

  final String flagEmoji;
  final String dialCode;
  final String name;

  String get label => '$flagEmoji $dialCode';
}

/// A deliberately minimal, real, hardcoded starter set of common countries
/// (correct flag emoji + dial codes). This is NOT full ISO 3166 coverage —
/// consumers needing the complete country list should pass their own via
/// [PhoneInput.countries].
const List<PhoneCountry> kDefaultPhoneCountries = [
  PhoneCountry(flagEmoji: '🇺🇸', dialCode: '+1', name: 'United States'),
  PhoneCountry(flagEmoji: '🇨🇦', dialCode: '+1', name: 'Canada'),
  PhoneCountry(flagEmoji: '🇬🇧', dialCode: '+44', name: 'United Kingdom'),
  PhoneCountry(flagEmoji: '🇦🇺', dialCode: '+61', name: 'Australia'),
  PhoneCountry(flagEmoji: '🇩🇪', dialCode: '+49', name: 'Germany'),
  PhoneCountry(flagEmoji: '🇫🇷', dialCode: '+33', name: 'France'),
  PhoneCountry(flagEmoji: '🇪🇸', dialCode: '+34', name: 'Spain'),
  PhoneCountry(flagEmoji: '🇮🇹', dialCode: '+39', name: 'Italy'),
  PhoneCountry(flagEmoji: '🇮🇳', dialCode: '+91', name: 'India'),
  PhoneCountry(flagEmoji: '🇯🇵', dialCode: '+81', name: 'Japan'),
  PhoneCountry(flagEmoji: '🇨🇳', dialCode: '+86', name: 'China'),
  PhoneCountry(flagEmoji: '🇧🇷', dialCode: '+55', name: 'Brazil'),
  PhoneCountry(flagEmoji: '🇲🇽', dialCode: '+52', name: 'Mexico'),
  PhoneCountry(flagEmoji: '🇿🇦', dialCode: '+27', name: 'South Africa'),
  PhoneCountry(flagEmoji: '🇳🇬', dialCode: '+234', name: 'Nigeria'),
];

/// The value reported by [PhoneInput.onChanged]: both a formatted display
/// string and the raw digits-only number, so consumers don't have to
/// re-derive whichever form they need (formatted for display, raw for
/// storage/validation/E.164 assembly).
class PhoneNumberValue {
  const PhoneNumberValue({required this.raw, required this.formatted});

  /// Digits only, no dial code, no separators (e.g. "5551234567").
  final String raw;

  /// Dial code + raw number as typed, with the country prefix (e.g.
  /// "+1 5551234567").
  final String formatted;
}

/// A text field with a tappable country-code prefix selector (flag emoji +
/// dial code) and a numeric keyboard.
class PhoneInput extends StatefulWidget {
  const PhoneInput({
    super.key,
    this.label,
    this.initialCountry,
    this.countries = kDefaultPhoneCountries,
    this.onChanged,
  
    this.theme,});

  final String? label;
  final PhoneCountry? initialCountry;
  final List<PhoneCountry> countries;
  final ValueChanged<PhoneNumberValue>? onChanged;

  final SyzygyTheme? theme;
  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late PhoneCountry _country = widget.initialCountry ?? widget.countries.first;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _emit() {
    final raw = _controller.text.replaceAll(RegExp(r'\D'), '');
    widget.onChanged?.call(PhoneNumberValue(raw: raw, formatted: '${_country.dialCode} ${_controller.text}'));
  }

  Future<void> _pickCountry() async {
    final colors = SyzygyThemeProvider.of(context).colors;
    final selected = await showModalBottomSheet<PhoneCountry>(
      context: context,
      backgroundColor: colors.surface,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: widget.countries
              .map((c) => ListTile(
                    leading: Text(c.flagEmoji, style: const TextStyle(fontSize: 20)),
                    title: Text(c.name),
                    trailing: Text(c.dialCode),
                    onTap: () => Navigator.of(context).pop(c),
                  ))
              .toList(),
        ),
      ),
    );
    if (selected != null) {
      setState(() => _country = selected);
      _emit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: 'Phone number input',
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: theme.colors.onSurface)),
          SizedBox(height: theme.spacing.xs),
        ],
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Row(
            children: [
              InkWell(
                onTap: _pickCountry,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radius.md),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Text(_country.label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: theme.colors.onSurface)),
                ),
              ),
              SizedBox(width: theme.spacing.sm),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-()]'))],
                  onChanged: (_) => _emit(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.colors.surface,
                    hintText: 'Phone number',
                    contentPadding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radius.md),
                      borderSide: BorderSide(color: theme.colors.border),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
