import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.6),
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modern Labs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                  ),
                  Text(
                    'Today, Oct 24',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: DoctorXColors.outline,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: DoctorXColors.clinicalGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: DoctorXColors.primary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.biotech,
                        size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: DoctorXColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              context.tokens.spacingMd,
              MediaQuery.of(context).padding.top + 80,
              context.tokens.spacingMd,
              MediaQuery.of(context).padding.bottom + 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics grid (Bento Style)
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: context.tokens.spacingMd,
                  crossAxisSpacing: context.tokens.spacingMd,
                  childAspectRatio: 1.5,
                  children: [
                    _buildMetricCard(
                      context,
                      title: 'TOTAL REQUESTS',
                      value: '124',
                      color: DoctorXColors.primary,
                      borderSide: DoctorXColors.primaryContainer,
                    ),
                    _buildMetricCard(
                      context,
                      title: 'READY',
                      value: '89',
                      color: DoctorXColors.tertiary,
                      borderSide: DoctorXColors.tertiary,
                    ),
                    _buildMetricCard(
                      context,
                      title: 'PROCESSING',
                      value: '35',
                      color: DoctorXColors.secondary,
                      borderSide: DoctorXColors.secondaryContainer,
                    ),
                    _buildMetricCard(
                      context,
                      title: 'AVG TAT',
                      value: '42m',
                      color: DoctorXColors.primary,
                      borderSide: DoctorXColors.outlineVariant,
                    ),
                  ],
                ),

                SizedBox(height: context.tokens.spacingXl),

                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Requests',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.goNamed(RouteNames.pendingRequests),
                      child: const Text('View All'),
                    ),
                  ],
                ),

                SizedBox(height: context.tokens.spacingSm),

                // Pending Requests List
                _buildRequestCard(
                  context,
                  patientName: 'Sarah Ahmed',
                  patientID: '#49201',
                  testType: 'Lipid Profile',
                  time: '14:05',
                  isUrgent: true,
                ),
                SizedBox(height: context.tokens.spacingMd),
                _buildRequestCard(
                  context,
                  patientName: 'Marcus Knight',
                  patientID: '#49195',
                  testType: 'Complete Blood Count (CBC)',
                  time: '13:42',
                  isUrgent: false,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: GlassCard(
          borderRadius: 24,
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.dashboard_outlined, Icons.dashboard, 'Home'),
              _buildNavItem(1, Icons.assignment_outlined, Icons.assignment, 'Requests'),
              _buildNavItem(2, Icons.analytics_outlined, Icons.analytics, 'Results'),
              _buildNavItem(3, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        if (index == 1) context.goNamed(RouteNames.pendingRequests);
        if (index == 2) context.goNamed(RouteNames.analytics);
        if (index == 3) context.goNamed(RouteNames.settings);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? DoctorXColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? DoctorXColors.primary : DoctorXColors.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isSelected ? DoctorXColors.primary : DoctorXColors.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
    required Color borderSide,
  }) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      border: Border(
        right: BorderSide(color: borderSide, width: 4),
        top: const BorderSide(color: DoctorXColors.glassBorderTop),
        left: const BorderSide(color: DoctorXColors.glassBorderTop),
        bottom: const BorderSide(color: DoctorXColors.glassBorderBottom),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: DoctorXColors.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: -1,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context, {
    required String patientName,
    required String patientID,
    required String testType,
    required String time,
    required bool isUrgent,
  }) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (isUrgent ? DoctorXColors.errorContainer : DoctorXColors.secondaryContainer).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isUrgent ? Icons.priority_high : Icons.biotech,
              color: isUrgent ? DoctorXColors.error : DoctorXColors.primary,
            ),
          ),
          SizedBox(width: context.tokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  testType,
                  style: TextStyle(color: DoctorXColors.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Oct 24, $time',
                  style: const TextStyle(color: DoctorXColors.outline, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isUrgent ? DoctorXColors.error : DoctorXColors.tertiary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isUrgent ? 'URGENT' : 'READY',
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.chevron_right, color: DoctorXColors.outline),
            ],
          ),
        ],
      ),
    );
  }
}
