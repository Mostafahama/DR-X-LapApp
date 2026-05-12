import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_x_lab_app/app/theme/colors.dart';
import 'package:doctor_x_lab_app/app/theme/spacing.dart';
import 'package:doctor_x_lab_app/core/widgets/glass_card.dart';
import 'package:doctor_x_lab_app/features/requests/presentation/pages/requests_dashboard_page.dart';
import 'package:doctor_x_lab_app/features/results/presentation/pages/results_queue_page.dart';
import 'package:doctor_x_lab_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:doctor_x_lab_app/features/dashboard/presentation/providers/shell_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(shellIndexProvider);
    final l10n = AppLocalizations.of(context)!;

    final List<Widget> _pages = [
      const RequestsDashboardPage(),
      const ResultsQueuePage(),
      const ChatListPage(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: GlassCard(
          borderRadius: 32,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          opacity: 0.95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, ref, 0, Icons.assignment_rounded, Icons.assignment, l10n.requests),
              _buildNavItem(context, ref, 1, Icons.analytics_rounded, Icons.analytics, l10n.results),
              _buildNavItem(context, ref, 2, Icons.chat_bubble_rounded, Icons.chat_bubble, l10n.chat),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, int index, IconData icon, IconData activeIcon, String label) {
    final selectedIndex = ref.watch(shellIndexProvider);
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => ref.read(shellIndexProvider.notifier).setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? DoctorXColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? DoctorXColors.primary : const Color(0xFF727687),
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: isSelected ? DoctorXColors.primary : const Color(0xFF727687),
            ),
          ),
        ],
      ),
    );
  }
}
