import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// A row of [length] fixed single-character boxes for OTP/PIN entry, with
/// auto-advancing focus as each digit is entered.
class OTPInput extends StatefulWidget {
  const OTPInput({
    super.key,
    this.length = 6,
    required this.code,
    required this.onCodeChange,
  
    this.theme,});

  final int length;
  final String code;
  final ValueChanged<String> onCodeChange;

  final SyzygyTheme? theme;
  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (i) => TextEditingController(text: i < widget.code.length ? widget.code[i] : ''),
    );
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    widget.onCodeChange(code);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: 'One-time passcode entry, ${widget.length} digits',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.length, (index) {
          return Padding(
            padding: EdgeInsets.only(right: index == widget.length - 1 ? 0 : theme.spacing.xs),
            child: SizedBox(
              width: 44,
              height: 52,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: Theme.of(context).textTheme.titleLarge,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: theme.colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radius.md),
                    borderSide: BorderSide(color: theme.colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radius.md),
                    borderSide: BorderSide(color: theme.colors.primary, width: 2),
                  ),
                ),
                onChanged: (value) => _handleChanged(index, value),
              ),
            ),
          );
        }),
      ),
    );
  }
}
