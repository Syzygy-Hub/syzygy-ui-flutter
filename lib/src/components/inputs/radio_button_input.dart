import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A single labeled radio option. Compose several with shared parent state
/// to build a radio group. Named `RadioButtonInput` for cross-platform
/// naming consistency across the Syzygy ecosystem.
///
/// Each instance still takes its own [groupValue]/[onChanged] — the same
/// consumer-driven "compose several, all pointed at the same group state"
/// pattern this widget always used — rather than requiring consumers to
/// restructure their code around a single shared [RadioGroup] ancestor
/// wrapping every option. Internally, [RadioGroup] is still used (required
/// by the current [Radio] API, since `Radio.groupValue`/`Radio.onChanged`
/// are deprecated), just scoped to wrap only this single [Radio] with this
/// instance's own group state — functionally equivalent to the old
/// per-instance `groupValue`/`onChanged` params, since the old API never
/// relied on implicit ancestor sharing between `Radio` instances either.
class RadioButtonInput<T> extends StatelessWidget {
  const RadioButtonInput({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.theme,
  });

  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final SyzygyTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final selected = value == groupValue;

    return Semantics(
      selected: selected,
      label: label,
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioGroup<T>(
              groupValue: groupValue,
              onChanged: (v) => onChanged(v as T),
              child: Radio<T>(
                value: value,
                activeColor: theme.colors.primary,
              ),
            ),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
