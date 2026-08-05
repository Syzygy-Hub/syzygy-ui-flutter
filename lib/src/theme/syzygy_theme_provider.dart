import 'package:flutter/widgets.dart';
import 'syzygy_theme.dart';

/// Injects a [SyzygyTheme] into the widget tree.
/// Place INSIDE MaterialApp (as a child, not a parent).
///
/// ```dart
/// MaterialApp(
///   home: SyzygyThemeProvider(
///     theme: SyzygyTheme.dark,
///     builder: (context, setTheme) => MyHomePage(),
///   ),
/// )
/// ```
class SyzygyThemeProvider extends StatefulWidget {
  const SyzygyThemeProvider({
    super.key,
    this.theme = SyzygyTheme.defaultTheme,
    required this.builder,
  });

  final SyzygyTheme theme;
  final Widget Function(BuildContext context, void Function(SyzygyTheme) setTheme) builder;

  static SyzygyTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_SyzygyThemeInherited>()?.theme
        ?? SyzygyTheme.defaultTheme;
  }

  @override
  State<SyzygyThemeProvider> createState() => _SyzygyThemeProviderState();
}

class _SyzygyThemeProviderState extends State<SyzygyThemeProvider> {
  late SyzygyTheme _theme;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme;
  }

  void _setTheme(SyzygyTheme theme) => setState(() => _theme = theme);

  @override
  Widget build(BuildContext context) {
    return _SyzygyThemeInherited(
      theme: _theme,
      child: widget.builder(context, _setTheme),
    );
  }
}

class _SyzygyThemeInherited extends InheritedWidget {
  const _SyzygyThemeInherited({required this.theme, required super.child});
  final SyzygyTheme theme;

  @override
  bool updateShouldNotify(_SyzygyThemeInherited old) => theme != old.theme;
}
