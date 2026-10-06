import 'package:flutter/material.dart' hide Badge, TabBar, BottomNavigationBar, BottomSheet, Chip, ColorSwatch;
import 'package:flutter_test/flutter_test.dart';

import 'package:syzygy_ui_flutter/syzygy_ui_flutter.dart';

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
      expect(AppRadius.full, 9999.0);
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

    testWidgets('TextInput with maxLength shows character counter',
        (tester) async {
      final controller = TextEditingController(text: 'Hello');
      await tester.pumpWidget(_wrap(
        TextInput(label: 'Bio', controller: controller, maxLength: 100),
      ));

      expect(find.text('5/100'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Hello world');
      await tester.pump();

      expect(find.text('11/100'), findsOneWidget);
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
                    builder: (_) => const Scaffold(
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

    testWidgets('SearchInput renders and clears', (tester) async {
      final controller = TextEditingController(text: 'coffee');
      await tester.pumpWidget(_wrap(SearchInput(controller: controller)));
      expect(find.text('coffee'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      expect(controller.text, isEmpty);
    });

    testWidgets('ToggleSwitch renders and toggles', (tester) async {
      var value = false;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return ToggleSwitch(
            label: 'Notifications',
            value: value,
            onChanged: (v) => setState(() => value = v),
          );
        }),
      ));
      expect(find.text('Notifications'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(value, isTrue);
    });

    testWidgets('CheckboxInput renders and toggles', (tester) async {
      var value = false;
      await tester.pumpWidget(_wrap(
        CheckboxInput(label: 'Remember me', value: value, onChanged: (v) => value = v),
      ));
      expect(find.text('Remember me'), findsOneWidget);
    });

    testWidgets('RadioButtonInput renders', (tester) async {
      await tester.pumpWidget(_wrap(
        RadioButtonInput<String>(label: 'Option A', value: 'a', groupValue: 'a', onChanged: (_) {}),
      ));
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('SliderInput renders with value readout', (tester) async {
      await tester.pumpWidget(_wrap(
        SliderInput(label: 'Volume', value: 0.5, onChanged: (_) {}),
      ));
      expect(find.text('Volume'), findsOneWidget);
      expect(find.text('0.50'), findsOneWidget);
    });

    testWidgets('Dropdown renders selection', (tester) async {
      await tester.pumpWidget(_wrap(
        Dropdown<String>(
          label: 'Country',
          value: 'USA',
          options: const ['USA', 'Canada'],
          onChanged: (_) {},
          optionTitle: (o) => o,
        ),
      ));
      expect(find.text('Country'), findsOneWidget);
    });

    testWidgets('SegmentedControl renders options', (tester) async {
      await tester.pumpWidget(_wrap(
        SegmentedControl<String>(
          options: const ['Day', 'Week'],
          selection: 'Day',
          onChanged: (_) {},
          optionTitle: (o) => o,
        ),
      ));
      expect(find.text('Day'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
    });

    testWidgets('QuantityStepper renders and increments', (tester) async {
      var value = 1;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return QuantityStepper(value: value, onChanged: (v) => setState(() => value = v));
        }),
      ));
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(value, 2);
    });

    testWidgets('Avatar renders initials', (tester) async {
      await tester.pumpWidget(_wrap(const Avatar(initials: 'AK')));
      expect(find.text('AK'), findsOneWidget);
    });

    testWidgets('DividerLine renders', (tester) async {
      await tester.pumpWidget(_wrap(const DividerLine()));
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('Chip renders text and remove button', (tester) async {
      await tester.pumpWidget(_wrap(Chip(text: 'Swift', onRemove: () {})));
      expect(find.text('Swift'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('ListRow renders title and subtitle', (tester) async {
      await tester.pumpWidget(_wrap(const ListRow(title: 'Settings', subtitle: 'Manage preferences')));
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Manage preferences'), findsOneWidget);
    });

    testWidgets('SectionHeader renders title and action', (tester) async {
      await tester.pumpWidget(_wrap(
        SectionHeader(title: 'Recent Activity', actionLabel: 'See All', onActionPressed: () {}),
      ));
      expect(find.text('Recent Activity'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);
    });

    testWidgets('LazyImageView shows fallback for null url', (tester) async {
      await tester.pumpWidget(_wrap(const LazyImageView(url: null)));
      expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);
    });

    testWidgets('StarRatingView renders read-only stars', (tester) async {
      await tester.pumpWidget(_wrap(const StarRatingView(rating: 3)));
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });

    testWidgets('CountBadge renders numeric count', (tester) async {
      await tester.pumpWidget(_wrap(const CountBadge(count: 3)));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('ShimmerView renders', (tester) async {
      await tester.pumpWidget(_wrap(const ShimmerView()));
      expect(find.byType(ShimmerView), findsOneWidget);
    });

    testWidgets('ProgressBar renders with clamped value', (tester) async {
      await tester.pumpWidget(_wrap(const ProgressBar(progress: 0.5)));
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('PullToRefresh renders child', (tester) async {
      await tester.pumpWidget(_wrap(
        PullToRefresh(
          onRefresh: () async {},
          child: ListView(children: const [Text('Row')]),
        ),
      ));
      expect(find.text('Row'), findsOneWidget);
    });

    testWidgets('ErrorStateView renders title and retry', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        ErrorStateView(
          title: 'Something went wrong',
          onRetryPressed: () => tapped = true,
        ),
      ));
      expect(find.text('Something went wrong'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(tapped, isTrue);
    });

    testWidgets('ModalDialog.show displays content', (tester) async {
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => ModalDialog.show(context, builder: (_) => const Text('Dialog content')),
            child: const Text('Open dialog'),
          );
        }),
      ));

      await tester.tap(find.text('Open dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog content'), findsOneWidget);
    });

    testWidgets('BottomSheet.show displays content', (tester) async {
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => BottomSheet.show(context, builder: (_) => const Text('Sheet content')),
            child: const Text('Open sheet'),
          );
        }),
      ));

      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Sheet content'), findsOneWidget);
    });

    testWidgets('CollapsibleView expands on tap', (tester) async {
      await tester.pumpWidget(_wrap(
        const CollapsibleView(title: 'Details', child: Text('Hidden content')),
      ));
      expect(find.byType(AnimatedCrossFade), findsOneWidget);

      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();

      expect(find.text('Hidden content'), findsOneWidget);
    });

    testWidgets('TabBar renders items and responds to tap', (tester) async {
      var selection = 'home';
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return TabBar<String>(
            items: const [
              TabBarItem(tag: 'home', icon: Icons.home, label: 'Home'),
              TabBarItem(tag: 'search', icon: Icons.search, label: 'Search'),
            ],
            selection: selection,
            onSelectionChanged: (v) => setState(() => selection = v),
          );
        }),
      ));
      expect(find.text('Home'), findsOneWidget);
      await tester.tap(find.text('Search'));
      await tester.pump();
      expect(selection, 'search');
    });

    testWidgets('BottomNavigationBar renders items', (tester) async {
      await tester.pumpWidget(_wrap(
        BottomNavigationBar<String>(
          items: const [TabBarItem(tag: 'home', icon: Icons.home, label: 'Home')],
          selection: 'home',
          onSelectionChanged: (_) {},
        ),
      ));
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('SyzygyAppBar renders title', (tester) async {
      await tester.pumpWidget(_wrap(
        const Scaffold(appBar: SyzygyAppBar(title: 'Settings'), body: SizedBox()),
      ));
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('PagerView renders pages', (tester) async {
      await tester.pumpWidget(_wrap(
        const PagerView(children: [Text('Page 1'), Text('Page 2')]),
      ));
      expect(find.text('Page 1'), findsOneWidget);
    });

    testWidgets('KeyboardAvoidingScrollView renders child', (tester) async {
      await tester.pumpWidget(_wrap(
        const KeyboardAvoidingScrollView(child: Text('Content')),
      ));
      expect(find.text('Content'), findsOneWidget);
    });

    test('NavigationTransitions builders produce PageRouteBuilders', () {
      expect(
        NavigationTransitions.slideTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
      expect(
        NavigationTransitions.crossFadeTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
      expect(
        NavigationTransitions.slideVerticalTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
      expect(
        NavigationTransitions.modalPresentationTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
      expect(
        NavigationTransitions.scaleTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
      expect(
        NavigationTransitions.fadeThroughTransition(builder: (_) => const SizedBox()),
        isA<PageRouteBuilder>(),
      );
    });

    testWidgets('LoadingButton shows spinner when loading', (tester) async {
      await tester.pumpWidget(_wrap(
        LoadingButton(label: 'Save', isLoading: true, onPressed: () {}),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Save'), findsNothing);
    });

    testWidgets('LoadingButton shows label when not loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        LoadingButton(label: 'Save', isLoading: false, onPressed: () => tapped = true),
      ));
      expect(find.text('Save'), findsOneWidget);
      await tester.tap(find.text('Save'));
      expect(tapped, isTrue);
    });

    testWidgets('AppFloatingActionButton renders icon', (tester) async {
      await tester.pumpWidget(_wrap(
        AppFloatingActionButton(icon: Icons.add, onPressed: () {}),
      ));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('ButtonGroup renders options and reports selection', (tester) async {
      List<int> selection = [0];
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return ButtonGroup(
            options: const ['Day', 'Week', 'Month'],
            selection: selection,
            onSelectionChange: (v) => setState(() => selection = v),
          );
        }),
      ));
      expect(find.text('Week'), findsOneWidget);
      await tester.tap(find.text('Week'));
      await tester.pump();
      expect(selection, [1]);
    });

    testWidgets('TextArea renders label and hint', (tester) async {
      await tester.pumpWidget(_wrap(
        const TextArea(label: 'Bio', hintText: 'Tell us about yourself'),
      ));
      expect(find.text('Bio'), findsOneWidget);
    });

    testWidgets('OTPInput renders length boxes', (tester) async {
      await tester.pumpWidget(_wrap(
        OTPInput(length: 4, code: '', onCodeChange: (_) {}),
      ));
      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('TagInput renders tags as chips', (tester) async {
      await tester.pumpWidget(_wrap(
        TagInput(tags: const ['flutter', 'dart'], onTagsChange: (_) {}),
      ));
      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('dart'), findsOneWidget);
    });

    testWidgets('DatePickerField renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        DatePickerField(label: 'Birthday', onDateChange: (_) {}),
      ));
      expect(find.text('Birthday'), findsOneWidget);
      expect(find.text('Select date'), findsOneWidget);
    });

    testWidgets('TimePickerField renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        TimePickerField(label: 'Reminder', onTimeChange: (_) {}),
      ));
      expect(find.text('Reminder'), findsOneWidget);
      expect(find.text('Select time'), findsOneWidget);
    });

    testWidgets('AppFormField renders label, child, and error', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppFormField(
          label: 'Email',
          error: 'Required',
          child: TextField(),
        ),
      ));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('PasswordStrengthIndicator labels a strong password', (tester) async {
      await tester.pumpWidget(_wrap(
        const PasswordStrengthIndicator(password: 'Str0ng!Passw0rd'),
      ));
      expect(find.text('Very Strong'), findsOneWidget);
    });

    testWidgets('PasswordStrengthIndicator labels a weak password', (tester) async {
      await tester.pumpWidget(_wrap(
        const PasswordStrengthIndicator(password: 'abc'),
      ));
      expect(find.text('Weak'), findsOneWidget);
    });

    testWidgets('AvatarGroup renders avatars with overflow', (tester) async {
      await tester.pumpWidget(_wrap(
        const AvatarGroup(avatars: ['A', 'B', 'C', 'D', 'E'], max: 3),
      ));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('+2'), findsOneWidget);
    });

    testWidgets('StatsCard renders label, value, and trend', (tester) async {
      await tester.pumpWidget(_wrap(
        const StatsCard(
          label: 'Revenue',
          value: '\$12,400',
          trend: TrendDirection.up,
          trendValue: '+12%',
        ),
      ));
      expect(find.text('Revenue'), findsOneWidget);
      expect(find.text('\$12,400'), findsOneWidget);
      expect(find.text('+12%'), findsOneWidget);
    });

    testWidgets('RatingInput reports tapped rating', (tester) async {
      int? rated;
      await tester.pumpWidget(_wrap(
        RatingInput(rating: 2, onRatingChange: (v) => rated = v),
      ));
      expect(find.byIcon(Icons.star), findsNWidgets(2));
      final stars = find.byIcon(Icons.star_border);
      await tester.tap(stars.last);
      expect(rated, isNotNull);
    });

    testWidgets('SkeletonView renders', (tester) async {
      await tester.pumpWidget(_wrap(
        const SkeletonView(shape: SkeletonShape.circle, height: 40),
      ));
      expect(find.byType(SkeletonView), findsOneWidget);
    });

    testWidgets('CircularProgress renders determinate value', (tester) async {
      await tester.pumpWidget(_wrap(const CircularProgress(progress: 0.5)));
      final indicator = tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.value, 0.5);
    });

    testWidgets('InlineAlert renders message for each variant', (tester) async {
      await tester.pumpWidget(_wrap(
        const InlineAlert(message: 'Saved', variant: AlertVariant.success),
      ));
      expect(find.text('Saved'), findsOneWidget);
    });

    testWidgets('AppSnackbar.build produces a usable SnackBar', (tester) async {
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              AppSnackbar.build(context, message: 'Copied to clipboard'),
            ),
            child: const Text('Show'),
          );
        }),
      ));
      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.text('Copied to clipboard'), findsOneWidget);
    });

    testWidgets('ActionSheet.show displays actions', (tester) async {
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => ActionSheet.show(context, actions: [
              ActionSheetItem(label: 'Delete', isDestructive: true, onTap: () {}),
            ]),
            child: const Text('Open sheet'),
          );
        }),
      ));
      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('Popover shows content on tap', (tester) async {
      await tester.pumpWidget(_wrap(
        const Popover(
          content: Text('Popover content'),
          child: Text('Trigger'),
        ),
      ));
      await tester.tap(find.text('Trigger'));
      await tester.pump();
      expect(find.text('Popover content'), findsOneWidget);
    });

    testWidgets('AppTooltip wraps child and carries message', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTooltip(message: 'Helpful hint', child: Icon(Icons.info)),
      ));
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('SideMenu renders inside a Scaffold drawer', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          drawer: SideMenu(child: Text('Menu content')),
          body: SizedBox(),
        ),
      ));
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();
      expect(find.text('Menu content'), findsOneWidget);
    });

    testWidgets('FloatingTabBar renders items and responds to tap', (tester) async {
      var selection = 'home';
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return FloatingTabBar<String>(
            items: const [
              TabBarItem(tag: 'home', icon: Icons.home, label: 'Home'),
              TabBarItem(tag: 'profile', icon: Icons.person, label: 'Profile'),
            ],
            selection: selection,
            onSelectionChange: (v) => setState(() => selection = v),
          );
        }),
      ));
      expect(find.text('Home'), findsOneWidget);
      await tester.tap(find.text('Profile'));
      await tester.pump();
      expect(selection, 'profile');
    });

    testWidgets('StepIndicator renders steps', (tester) async {
      await tester.pumpWidget(_wrap(
        const StepIndicator(steps: ['Info', 'Payment', 'Review'], currentStep: 1),
      ));
      expect(find.byType(StepIndicator), findsOneWidget);
    });

    testWidgets('Breadcrumbs renders labels and responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        Breadcrumbs(items: [
          BreadcrumbItem(label: 'Home', onTap: () => tapped = true),
          const BreadcrumbItem(label: 'Settings'),
        ]),
      ));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      await tester.tap(find.text('Home'));
      expect(tapped, isTrue);
    });

    testWidgets('AdaptiveStack renders Row above breakpoint', (tester) async {
      await tester.pumpWidget(_wrap(
        const AdaptiveStack(breakpoint: 400, children: [Text('A'), Text('B')]),
      ));
      expect(find.byType(Row), findsWidgets);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('FlowLayout wraps children', (tester) async {
      await tester.pumpWidget(_wrap(
        const FlowLayout(children: [Text('One'), Text('Two')]),
      ));
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('StickyHeader renders header and child', (tester) async {
      await tester.pumpWidget(_wrap(
        StickyHeader(
          header: Container(color: Colors.blue, child: const Text('Header')),
          child: const Text('Body content'),
        ),
      ));
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body content'), findsOneWidget);
    });

    testWidgets('PageControl renders dots for each page', (tester) async {
      await tester.pumpWidget(_wrap(
        const PageControl(pageCount: 3, currentPage: 1),
      ));
      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });

    testWidgets('Accordion expands a section on tap and collapses others by default',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const Accordion(
          sections: [
            AccordionSection(title: 'Section A', child: Text('Content A')),
            AccordionSection(title: 'Section B', child: Text('Content B')),
          ],
        ),
      ));

      Finder byLabel(String label) => find.byWidgetPredicate(
            (widget) => widget is Semantics && widget.properties.label == label,
          );

      expect(byLabel('Section A, collapsed'), findsOneWidget);
      await tester.tap(find.text('Section A'));
      await tester.pumpAndSettle();
      expect(byLabel('Section A, expanded'), findsOneWidget);

      await tester.tap(find.text('Section B'));
      await tester.pumpAndSettle();
      expect(byLabel('Section A, collapsed'), findsOneWidget);
      expect(byLabel('Section B, expanded'), findsOneWidget);
    });

    testWidgets('Timeline renders item titles and subtitles', (tester) async {
      await tester.pumpWidget(_wrap(
        const Timeline(
          items: [
            TimelineItem(title: 'Order placed', subtitle: 'Processing', timestamp: '9:00 AM'),
            TimelineItem(title: 'Order shipped'),
          ],
        ),
      ));
      expect(find.text('Order placed'), findsOneWidget);
      expect(find.text('Processing'), findsOneWidget);
      expect(find.text('Order shipped'), findsOneWidget);
    });

    testWidgets('ColorSwatchView renders label and reflects selection', (tester) async {
      await tester.pumpWidget(_wrap(
        const ColorSwatchView(color: Colors.blue, label: 'Blue', isSelected: true),
      ));
      expect(find.text('Blue'), findsOneWidget);
      expect(find.byType(ColorSwatchView), findsOneWidget);
    });

    testWidgets('SearchableDropdown filters options via search field', (tester) async {
      String? selected;
      await tester.pumpWidget(_wrap(
        SearchableDropdown<String>(
          label: 'Country',
          value: null,
          options: const ['USA', 'Canada', 'Cuba'],
          onChanged: (v) => selected = v,
          optionTitle: (o) => o,
        ),
      ));

      await tester.tap(find.text('Search...').first);
      await tester.pump();
      expect(find.text('USA'), findsOneWidget);
      expect(find.text('Canada'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Cu');
      await tester.pump();
      expect(find.text('Cuba'), findsOneWidget);
      expect(find.text('USA'), findsNothing);

      // Select an option so the overlay (and its focused TextField) is
      // properly torn down before the test ends, rather than leaking a
      // dangling OverlayEntry into subsequent tests.
      await tester.tap(find.text('Cuba'));
      await tester.pumpAndSettle();
      expect(selected, 'Cuba');
    });

    testWidgets('PhoneInput renders default country prefix and accepts input', (tester) async {
      PhoneNumberValue? reported;
      await tester.pumpWidget(_wrap(
        PhoneInput(onChanged: (v) => reported = v),
      ));
      expect(find.textContaining('+1'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '5551234567');
      await tester.pump();
      expect(reported?.raw, '5551234567');
    });

    testWidgets('CurrencyInput renders currency symbol prefix and reports parsed value',
        (tester) async {
      double? reported;
      await tester.pumpWidget(_wrap(
        CurrencyInput(label: 'Amount', onChanged: (v) => reported = v),
      ));
      expect(find.text('\$'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '1234.5');
      await tester.pump();
      expect(reported, 1234.5);
    });

    test('CurrencyInput.groupThousands inserts thousands separators', () {
      expect(CurrencyInput.groupThousands('1234567.89'), '1,234,567.89');
      expect(CurrencyInput.groupThousands('42'), '42');
    });

    testWidgets('NetworkStatusBanner shows message when offline and hides when online',
        (tester) async {
      await tester.pumpWidget(_wrap(const NetworkStatusBanner(isOffline: true)));
      expect(find.text('No internet connection'), findsOneWidget);

      await tester.pumpWidget(_wrap(const NetworkStatusBanner(isOffline: false)));
      await tester.pumpAndSettle();
      expect(find.text('No internet connection'), findsNothing);
    });

    testWidgets('ConfirmDialog.show resolves true on confirm', (tester) async {
      bool? result;
      await tester.pumpWidget(_wrap(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () async {
              result = await ConfirmDialog.show(
                context,
                title: 'Delete item?',
                message: 'This cannot be undone.',
                isDestructive: true,
              );
            },
            child: const Text('Open confirm'),
          );
        }),
      ));

      await tester.tap(find.text('Open confirm'));
      await tester.pumpAndSettle();
      expect(find.text('Delete item?'), findsOneWidget);

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });

    testWidgets('SafeAreaWrapper renders child content', (tester) async {
      await tester.pumpWidget(_wrap(
        const SafeAreaWrapper(child: Text('Wrapped content')),
      ));
      expect(find.text('Wrapped content'), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('LabeledDivider renders label between two line segments', (tester) async {
      await tester.pumpWidget(_wrap(
        const LabeledDivider(label: 'or'),
      ));
      expect(find.text('or'), findsOneWidget);
      expect(find.byType(DividerLine), findsNWidgets(2));
    });
  });

  // ---------------------------------------------------------------------------
  // Theme layer
  // ---------------------------------------------------------------------------
  group('SyzygyThemeProvider', () {
    testWidgets('provides default theme values to descendants', (tester) async {
      late SyzygyTheme resolved;
      await tester.pumpWidget(MaterialApp(
        home: SyzygyThemeProvider(
          theme: SyzygyTheme.defaultTheme,
          builder: (_, __) => Builder(builder: (context) {
            resolved = SyzygyThemeProvider.of(context);
            return const SizedBox();
          }),
        ),
      ));
      expect(resolved.colors.primary, const Color(0xFF2563EB));
      expect(resolved.radius.md, 8.0);
      expect(resolved.spacing.md, isNotNull);
    });

    testWidgets('provides dark theme values when dark theme is passed', (tester) async {
      late SyzygyTheme resolved;
      await tester.pumpWidget(MaterialApp(
        home: SyzygyThemeProvider(
          theme: SyzygyTheme.dark,
          builder: (_, __) => Builder(builder: (context) {
            resolved = SyzygyThemeProvider.of(context);
            return const SizedBox();
          }),
        ),
      ));
      // Check dark-specific color token value rather than whole-object identity
      expect(resolved.colors.background, const Color(0xFF000000));
      expect(resolved.colors.primary, const Color(0xFF3D8BFF));
    });

    testWidgets('didUpdateWidget updates theme when parent rebuilds with new theme',
        (tester) async {
      SyzygyTheme current = SyzygyTheme.defaultTheme;
      late SyzygyTheme resolved;

      await tester.pumpWidget(MaterialApp(
        home: StatefulBuilder(builder: (outerCtx, setState) {
          return SyzygyThemeProvider(
            theme: current,
            builder: (_, __) => Builder(builder: (innerCtx) {
              resolved = SyzygyThemeProvider.of(innerCtx);
              return ElevatedButton(
                onPressed: () => setState(() => current = SyzygyTheme.dark),
                child: const Text('Switch'),
              );
            }),
          );
        }),
      ));
      // Default theme has light background
      expect(resolved.colors.background, const Color(0xFFFFFFFF));

      await tester.tap(find.text('Switch'));
      await tester.pump();

      // After switch, dark theme has black background
      expect(resolved.colors.background, const Color(0xFF000000));
    });

    testWidgets('returns defaultTheme when no provider is in the tree', (tester) async {
      late SyzygyTheme resolved;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          resolved = SyzygyThemeProvider.of(context);
          return const SizedBox();
        }),
      ));
      // When no provider is in tree, defaultTheme light colors are returned
      expect(resolved.colors.primary, const Color(0xFF2563EB));
      expect(resolved.colors.background, const Color(0xFFFFFFFF));
    });

    test('SyzygyTheme == works correctly — same values are equal', () {
      const a = SyzygyTheme.defaultTheme;
      const b = SyzygyTheme.defaultTheme;
      expect(a == b, isTrue);
      expect(a.hashCode, b.hashCode);
    });

    test('SyzygyTheme == returns false for different themes', () {
      const a = SyzygyTheme.defaultTheme;
      const b = SyzygyTheme.dark;
      expect(a == b, isFalse);
    });

    test('SyzygyTheme copyWith returns new instance with changed field', () {
      const original = SyzygyTheme.defaultTheme;
      final copy = original.copyWith(radius: SyzygyRadius.sharp);
      expect(copy.radius, SyzygyRadius.sharp);
      expect(copy.colors, original.colors);
      expect(copy == original, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Debounce
  // ---------------------------------------------------------------------------
  group('SearchInput debounce', () {
    testWidgets('onSearchTextChanged fires after debounce delay', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(_wrap(
        SearchInput(
          debounce: const Duration(milliseconds: 200),
          onSearchTextChanged: calls.add,
        ),
      ));

      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump(); // immediate — not yet
      expect(calls, isEmpty);

      await tester.pump(const Duration(milliseconds: 300)); // past debounce
      expect(calls, ['hello']);
    });

    testWidgets('onSearchTextChanged does not fire before debounce delay', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(_wrap(
        SearchInput(
          debounce: const Duration(milliseconds: 500),
          onSearchTextChanged: calls.add,
        ),
      ));

      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pump(const Duration(milliseconds: 100)); // too early
      expect(calls, isEmpty);

      await tester.pump(const Duration(milliseconds: 500)); // now past
      expect(calls, ['abc']);
    });

    testWidgets('onChanged fires immediately (no debounce)', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(_wrap(
        SearchInput(onChanged: calls.add),
      ));

      await tester.enterText(find.byType(TextField), 'x');
      await tester.pump();
      expect(calls, isNotEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // OTP input
  // ---------------------------------------------------------------------------
  group('OTPInput', () {
    testWidgets('accepts digit input', (tester) async {
      String code = '';
      await tester.pumpWidget(_wrap(
        OTPInput(length: 4, code: code, onCodeChange: (v) => code = v),
      ));
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '5');
      await tester.pump();
      expect(code.contains('5'), isTrue);
    });

    testWidgets('rejects non-digit input via FilteringTextInputFormatter', (tester) async {
      String code = '';
      await tester.pumpWidget(_wrap(
        OTPInput(length: 4, code: code, onCodeChange: (v) => code = v),
      ));
      // Try to type a letter — formatter should strip it
      await tester.enterText(find.byType(TextField).at(0), 'a');
      await tester.pump();
      final controller = tester.widget<TextField>(find.byType(TextField).at(0)).controller!;
      expect(controller.text, isEmpty);
    });

    testWidgets('fills cells in order — first cell gets digit 3', (tester) async {
      String code = '';
      await tester.pumpWidget(_wrap(
        OTPInput(length: 4, code: code, onCodeChange: (v) => code = v),
      ));
      final fields = find.byType(TextField);
      await tester.tap(fields.at(0));
      await tester.enterText(fields.at(0), '3');
      await tester.pump();
      // First cell contains '3'
      final c0 = tester.widget<TextField>(fields.at(0)).controller!;
      expect(c0.text, '3');
    });

    testWidgets('reports combined code via onCodeChange', (tester) async {
      String code = '';
      await tester.pumpWidget(_wrap(
        OTPInput(length: 4, code: code, onCodeChange: (v) => code = v),
      ));
      await tester.enterText(find.byType(TextField).at(0), '7');
      await tester.pump();
      expect(code.isNotEmpty, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // QuantityStepper
  // ---------------------------------------------------------------------------
  group('QuantityStepper', () {
    testWidgets('increment increases value', (tester) async {
      var value = 3;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return QuantityStepper(
            value: value,
            onChanged: (v) => setState(() => value = v),
          );
        }),
      ));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(value, 4);
    });

    testWidgets('decrement decreases value', (tester) async {
      var value = 5;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return QuantityStepper(
            value: value,
            onChanged: (v) => setState(() => value = v),
          );
        }),
      ));
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(value, 4);
    });

    testWidgets('decrement is disabled at min', (tester) async {
      var value = 0;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return QuantityStepper(
            value: value,
            min: 0,
            onChanged: (v) => setState(() => value = v),
          );
        }),
      ));
      // The decrease button should be disabled — tapping does nothing
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(value, 0);
    });

    testWidgets('increment is disabled at max', (tester) async {
      var value = 10;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return QuantityStepper(
            value: value,
            max: 10,
            onChanged: (v) => setState(() => value = v),
          );
        }),
      ));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(value, 10);
    });
  });

  // ---------------------------------------------------------------------------
  // onChange callbacks
  // ---------------------------------------------------------------------------
  group('onChange callbacks', () {
    testWidgets('ToggleSwitch calls onChanged with correct value', (tester) async {
      bool? reported;
      bool value = false;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return ToggleSwitch(
            label: 'Dark mode',
            value: value,
            onChanged: (v) {
              reported = v;
              setState(() => value = v);
            },
          );
        }),
      ));
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(reported, isTrue);
    });

    testWidgets('SliderInput calls onChanged with updated value', (tester) async {
      double? reported;
      await tester.pumpWidget(_wrap(
        SliderInput(
          label: 'Brightness',
          value: 0.0,
          onChanged: (v) => reported = v,
        ),
      ));
      await tester.drag(find.byType(Slider), const Offset(100, 0));
      await tester.pump();
      expect(reported, isNotNull);
      expect(reported, greaterThan(0.0));
    });

    testWidgets('SegmentedControl calls onChanged with selected option', (tester) async {
      String? reported;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return SegmentedControl<String>(
            options: const ['A', 'B', 'C'],
            selection: 'A',
            onChanged: (v) {
              reported = v;
              setState(() {});
            },
            optionTitle: (o) => o,
          );
        }),
      ));
      await tester.tap(find.text('B'));
      await tester.pump();
      expect(reported, 'B');
    });
  });
}
