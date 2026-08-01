import 'package:flutter/material.dart';

/// Reusable [PageRouteBuilder] factories for common navigation/presentation
/// motion, following Flutter's own custom-transition idiom (a
/// `transitionsBuilder` wrapping the child in `SlideTransition`/
/// `FadeTransition`).
class NavigationTransitions {
  NavigationTransitions._();

  static const _duration = Duration(milliseconds: 300);

  /// Slides a page in/out horizontally.
  static PageRouteBuilder<T> slideTransition<T>({
    required WidgetBuilder builder,
    bool leftToRight = true,
  }) {
    final begin = Offset(leftToRight ? -1 : 1, 0);
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(animation),
          child: child,
        );
      },
    );
  }

  /// A plain cross-fade between the outgoing and incoming page.
  static PageRouteBuilder<T> crossFadeTransition<T>({required WidgetBuilder builder}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Slides a page in/out vertically.
  static PageRouteBuilder<T> slideVerticalTransition<T>({
    required WidgetBuilder builder,
    bool topToBottom = true,
  }) {
    final begin = Offset(0, topToBottom ? -1 : 1);
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(animation),
          child: child,
        );
      },
    );
  }

  /// A slide-up-and-fade transition suited to modal/sheet presentation.
  static PageRouteBuilder<T> modalPresentationTransition<T>({required WidgetBuilder builder}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
