import 'package:flutter/material.dart' hide Badge, TabBar, BottomNavigationBar, BottomSheet, Chip;
import 'package:syzygy_ui_flutter/syzygy_ui_flutter.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'syzygy_ui_flutter example',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const ComponentGalleryPage(),
    );
  }
}

class ComponentGalleryPage extends StatelessWidget {
  const ComponentGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SyzygyAppBar(
        leading: AppBackButton(onPressed: () {}),
        title: 'syzygy_ui_flutter',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          PrimaryButton(label: 'Primary', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          SecondaryButton(label: 'Secondary', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          DestructiveButton(label: 'Delete', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          GhostButton(label: 'Ghost', onPressed: () {}),
          const SizedBox(height: AppSpacing.md),
          const TextInput(label: 'Email', hintText: 'you@example.com'),
          const SizedBox(height: AppSpacing.md),
          const TextInput(
            label: 'Bio',
            hintText: 'Tell us about yourself',
            maxLength: 100,
          ),
          const SizedBox(height: AppSpacing.md),
          const SecureInput(label: 'Password'),
          const SizedBox(height: AppSpacing.md),
          const CardView(child: Text('A simple card')),
          const SizedBox(height: AppSpacing.md),
          const Wrap(
            spacing: AppSpacing.sm,
            children: [
              Badge(text: 'New', variant: BadgeVariant.primary),
              Badge(text: 'Success', variant: BadgeVariant.success),
              Badge(text: 'Warning', variant: BadgeVariant.warning),
              Badge(text: 'Error', variant: BadgeVariant.error),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'Show toast',
            onPressed: () => ToastView.show(
              context,
              message: 'Saved successfully',
              variant: ToastVariant.success,
            ),
          ),
        ],
      ),
    );
  }
}
