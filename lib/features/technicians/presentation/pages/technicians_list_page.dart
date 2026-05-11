import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';

class TechniciansListPage extends ConsumerWidget {
  const TechniciansListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DoctorXColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: EdgeInsets.all(context.tokens.spacingMd),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final isManager = index == 0;
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.tokens.spacingMd),
                    child: _buildStaffCard(context, index, isManager),
                  );
                },
                childCount: 8,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: DoctorXColors.primary,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.tokens.radiusMd)),
        child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
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
          'Staff Portal',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: DoctorXColors.onSurface,
              ),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, int index, bool isManager) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.6,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: DoctorXColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.tokens.radiusMd),
                ),
                child: const Icon(Icons.person_rounded, color: DoctorXColors.primary, size: 32),
              ),
              if (isManager)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: DoctorXColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_rounded, size: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(width: context.tokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Staff Member ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  isManager ? 'Control Tower Manager' : 'Laboratory Specialist',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isManager ? DoctorXColors.primary : DoctorXColors.outline,
                        fontWeight: isManager ? FontWeight.w900 : FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (index % 3 == 0) ? DoctorXColors.success.withOpacity(0.1) : DoctorXColors.outline.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  (index % 3 == 0) ? 'ACTIVE' : 'OFFLINE',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: (index % 3 == 0) ? DoctorXColors.success : DoctorXColors.outline,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, color: DoctorXColors.outline),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
