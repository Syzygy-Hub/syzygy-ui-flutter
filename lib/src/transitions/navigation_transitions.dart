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

  /// Scales the incoming page in (and the outgoing page out) combined with
  /// a fade.
  static PageRouteBuilder<T> scaleTransition<T>({required WidgetBuilder builder}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  /// A "fade through" transition: the outgoing page fades out first, then
  /// the incoming page fades in — sequenced, not a simultaneous cross-fade
  /// like [crossFadeTransition]. Implemented via two non-overlapping
  /// [Interval]s of the same transition animation.
  static PageRouteBuilder<T> fadeThroughTransition<T>({required WidgetBuilder builder}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // First half: fade the outgoing content out. Second half: fade the
        // incoming content in. Both stages are driven by the same
        // `animation`, just scoped to non-overlapping intervals.
        final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: animation, curve: const Interval(0.0, 0.5)),
        );
        final fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: const Interval(0.5, 1.0)),
        );

        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) {
            final opacity = animation.value < 0.5 ? fadeOut.value : fadeIn.value;
            return Opacity(opacity: opacity, child: child);
          },
        );
      },
    );
  }
}
