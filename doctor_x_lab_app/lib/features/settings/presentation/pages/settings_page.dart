import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../app/providers/locale_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: DoctorXColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.tokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Lab Profile Card
                  _buildLabProfileCard(context),
                  SizedBox(height: context.tokens.spacingXl),

                  _buildSectionLabel(context, 'MANAGEMENT'),
                  SizedBox(height: context.tokens.spacingSm),
                  _buildSettingsGroup(context, [
                    _SettingsItem(
                      icon: Icons.science_rounded,
                      title: 'Test Catalog',
                      subtitle: 'Master list of tests',
                      onTap: () => context.pushNamed('test_catalog'),
                    ),
                    _SettingsItem(
                      icon: Icons.people_rounded,
                      title: 'Staff Management',
                      subtitle: 'Roles and access',
                      onTap: () => context.pushNamed('technicians'),
                    ),
                    _SettingsItem(
                      icon: Icons.schedule_rounded,
                      title: 'Working Hours',
                      subtitle: 'Shift management',
                      onTap: () {},
                    ),
                  ]),

                  SizedBox(height: context.tokens.spacingXl),
                  _buildSectionLabel(context, 'SYSTEM'),
                  SizedBox(height: context.tokens.spacingSm),
                  _buildSettingsGroup(context, [
                    _SettingsItem(
                      icon: Icons.notifications_rounded,
                      title: 'Alerts',
                      subtitle: 'Push & system alerts',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.language_rounded,
                      title: 'Localization',
                      subtitle: locale.languageCode == 'en' ? 'English (US)' : 'العربية (Egypt)',
                      onTap: () {
                        ref.read(localeProvider.notifier).state =
                            locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
                      },
                    ),
                  ]),

                  SizedBox(height: context.tokens.spacingXxl),
                  _buildSignOutButton(context),
                  SizedBox(height: context.tokens.spacingXxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: DoctorXColors.surface.withOpacity(0.8),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: DoctorXColors.onSurface,
              ),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
      ),
    );
  }

  Widget _buildLabProfileCard(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.8,
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: DoctorXColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.tokens.radiusMd),
            ),
            child: const Icon(Icons.biotech_rounded, size: 36, color: DoctorXColors.primary),
          ),
          SizedBox(width: context.tokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modern Diagnostic Labs',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  'License: #DX-2024-88',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: DoctorXColors.outline, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Branch: Downtown HQ',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: DoctorXColors.outline),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: DoctorXColors.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: DoctorXColors.outline,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<_SettingsItem> items) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: context.tokens.radiusLg,
      opacity: 0.4,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: DoctorXColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.icon, color: DoctorXColors.primary, size: 20),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                subtitle: Text(item.subtitle, style: const TextStyle(color: DoctorXColors.outline, fontSize: 11)),
                trailing: const Icon(Icons.chevron_right_rounded, size: 20, color: DoctorXColors.outline),
                onTap: item.onTap,
              ),
              if (!isLast) Divider(height: 1, color: DoctorXColors.outline.withOpacity(0.05), indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: DoctorXColors.error.withOpacity(0.1),
        foregroundColor: DoctorXColors.error,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.tokens.radiusMd)),
        elevation: 0,
      ),
      child: const Text('SIGN OUT ACCOUNT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
