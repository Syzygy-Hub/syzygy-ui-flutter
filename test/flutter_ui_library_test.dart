import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ui_library/flutter_ui_library.dart';

Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? AppTheme.light(),
    home: Scaffold(body: child),
  );
}

void main() {
  group('tokens', () {
    test('spacing scale has expected values', () {
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.sm, 8.0);
      expect(AppSpacing.md, 16.0);
      expect(AppSpacing.lg, 24.0);
      expect(AppSpacing.xl, 32.0);
      expect(AppSpacing.xxl, 48.0);
    });

    test('radius scale has expected values', () {
      expect(AppRadius.sm, 4.0);
      expect(AppRadius.md, 8.0);
      expect(AppRadius.lg, 16.0);
      expect(AppRadius.full, 999.0);
    });

    test('light and dark color tokens exist and differ', () {
      expect(AppColors.light.primary, isNotNull);
      expect(AppColors.dark.primary, isNotNull);
      expect(AppColors.light.background, isNot(AppColors.dark.background));
    });

    testWidgets('AppColors.of resolves light theme extension', (tester) async {
      late AppColors resolved;

      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          resolved = AppColors.of(context);
          return const SizedBox();
        }),
        theme: AppTheme.light(),
      ));

      expect(resolved.background, AppColors.light.background);
    });

    testWidgets('AppColors.of resolves dark theme extension', (tester) async {
      late AppColors resolved;

      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          resolved = AppColors.of(context);
          return const SizedBox();
        }),
        theme: AppTheme.dark(),
      ));

      expect(resolved.background, AppColors.dark.background);
    });
  });

  group('component smoke tests', () {
    testWidgets('PrimaryButton renders and responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        PrimaryButton(label: 'Continue', onPressed: () => tapped = true),
      ));

      expect(find.text('Continue'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      expect(tapped, isTrue);
    });

    testWidgets('SecondaryButton renders', (tester) async {
      await tester.pumpWidget(_wrap(
        SecondaryButton(label: 'Cancel', onPressed: () {}),
      ));
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('DestructiveButton renders', (tester) async {
      await tester.pumpWidget(_wrap(
        DestructiveButton(label: 'Delete', onPressed: () {}),
      ));
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('GhostButton renders', (tester) async {
      await tester.pumpWidget(_wrap(
        GhostButton(label: 'Skip', onPressed: () {}),
      ));
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('AppIconButton renders with semantic label', (tester) async {
      await tester.pumpWidget(_wrap(
        AppIconButton(
          icon: Icons.add,
          onPressed: () {},
          semanticLabel: 'Add item',
        ),
      ));
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.bySemanticsLabel('Add item'), findsOneWidget);
    });

    testWidgets('TextInput renders label and hint', (tester) async {
      await tester.pumpWidget(_wrap(
        const TextInput(label: 'Email', hintText: 'you@example.com'),
      ));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('you@example.com'), findsOneWidget);
    });

    testWidgets('SecureInput toggles obscure text', (tester) async {
      await tester.pumpWidget(_wrap(
        const SecureInput(label: 'Password'),
      ));
      expect(find.text('Password'), findsOneWidget);

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();

      final toggledField = tester.widget<TextField>(find.byType(TextField));
      expect(toggledField.obscureText, isFalse);
    });

    testWidgets('LoadingView renders indicator and message', (tester) async {
      await tester.pumpWidget(_wrap(
        const LoadingView(message: 'Loading data'),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading data'), findsOneWidget);
    });

    testWidgets('EmptyStateView renders title, subtitle, and CTA',
        (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        EmptyStateView(
          icon: Icons.inbox_outlined,
          title: 'Nothing here',
          subtitle: 'Try again later',
          ctaLabel: 'Retry',
          onCtaPressed: () => tapped = true,
        ),
      ));

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Try again later'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(tapped, isTrue);
    });

    testWidgets('ToastView.show displays a snackbar with message',
        (tester) async {
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => ToastView.show(
              context,
              message: 'Saved successfully',
              variant: ToastVariant.success,
            ),
            child: const Text('Show toast'),
          );
        }),
      ));

      await tester.tap(find.text('Show toast'));
      await tester.pump();

      expect(find.text('Saved successfully'), findsOneWidget);
    });

    testWidgets('CardView renders child content', (tester) async {
      await tester.pumpWidget(_wrap(
        const CardView(child: Text('Card content')),
      ));
      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('Badge renders text for each variant', (tester) async {
      await tester.pumpWidget(_wrap(
        const Column(
          children: [
            Badge(text: 'New', variant: BadgeVariant.primary),
            Badge(text: 'Done', variant: BadgeVariant.success),
            Badge(text: 'Pending', variant: BadgeVariant.warning),
            Badge(text: 'Failed', variant: BadgeVariant.error),
          ],
        ),
      ));

      expect(find.text('New'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('AppBackButton triggers navigation pop', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        home: Builder(builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      body: AppBackButton(),
                    ),
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          );
        }),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Open'), findsOneWidget);
    });
  });
}
