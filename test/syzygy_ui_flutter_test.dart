import 'package:flutter/material.dart' hide Badge, TabBar, BottomNavigationBar, BottomSheet, Chip;
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
        AppFormField(
          label: 'Email',
          error: 'Required',
          child: const TextField(),
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
        Popover(
          content: const Text('Popover content'),
          child: const Text('Trigger'),
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
        home: Scaffold(
          drawer: const SideMenu(child: Text('Menu content')),
          body: const SizedBox(),
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
  });
}
