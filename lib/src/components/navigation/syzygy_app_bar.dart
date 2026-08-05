import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A top navigation bar with a centered title and optional leading/trailing
/// accessories. Implements [PreferredSizeWidget] so it can be dropped
/// directly into `Scaffold(appBar: ...)`.
///
/// Named `SyzygyAppBar` (not `AppBar`) so it can be imported alongside
/// `package:flutter/material.dart` without requiring consumers to write
/// `hide AppBar` — unlike `Chip`/`TabBar`/`BottomNavigationBar`/
/// `BottomSheet`/`ModalDialog`, `AppBar` is used constantly by consumers
/// for their own screens, so forcing a hide on every file that imports both
/// this package and Material would be too disruptive.
class SyzygyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SyzygyAppBar({super.key, required this.title, this.leading, this.actions,
    this.theme,});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  final SyzygyTheme? theme;
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      header: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.surface,
          border: Border(bottom: BorderSide(color: theme.colors.border)),
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 56,
            child: NavigationToolbar(
              leading: leading,
              middle: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: theme.colors.onSurface),
              ),
              trailing: actions == null ? null : Row(mainAxisSize: MainAxisSize.min, children: actions!),
              centerMiddle: true,
            ),
          ),
        ),
      ),
    );
  }
}
