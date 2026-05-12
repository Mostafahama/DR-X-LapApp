import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../data/models/lab_request_model.dart';
import '../providers/lab_request_providers.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../data/models/lab_request_model.dart';
import '../providers/lab_request_providers.dart';

class PendingRequestsPage extends ConsumerWidget {
  const PendingRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingRequestsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.6),
              elevation: 0,
              title: const Text('Laboratory Queue', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: 200,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: DoctorXColors.primary.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),
          requestsAsync.when(
            data: (requests) => RefreshIndicator(
              onRefresh: () => ref.refresh(pendingRequestsProvider.future),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spacingMd,
                  MediaQuery.of(context).padding.top + 80,
                  context.tokens.spacingMd,
                  100,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bento Metrics
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildMiniMetric(context, 'URGENT', '04', DoctorXColors.error),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: _buildMiniMetric(context, 'TOTAL QUEUE', '12', DoctorXColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildGlassFilterChip(context, 'All Tasks', isSelected: true),
                          const SizedBox(width: 8),
                          _buildGlassFilterChip(context, 'Critical', isSelected: false),
                          const SizedBox(width: 8),
                          _buildGlassFilterChip(context, 'Routine', isSelected: false),
                        ],
                      ),
                    ),
                    SizedBox(height: context.tokens.spacingLg),

                    // Search Bar
                    GlassCard(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      borderRadius: 12,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by ID or Name...',
                          hintStyle: TextStyle(color: DoctorXColors.outline, fontSize: 14),
                          prefixIcon: const Icon(Icons.search, size: 20, color: DoctorXColors.outline),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: context.tokens.spacingLg),

                    // List of Requests
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return _buildLiquidRequestCard(context, request);
                      },
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMetric(BuildContext context, String label, String value, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: DoctorXColors.outline)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  Widget _buildGlassFilterChip(BuildContext context, String label, {required bool isSelected}) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: 100,
      opacity: isSelected ? 0.9 : 0.4,
      border: isSelected ? Border.all(color: DoctorXColors.primary.withOpacity(0.3), width: 1.5) : null,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? DoctorXColors.primary : DoctorXColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildLiquidRequestCard(BuildContext context, LabRequest request) {
    final isUrgent = request.isUrgent;
    return GestureDetector(
      onTap: () => context.pushNamed(RouteNames.requestDetail, extra: request),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isUrgent 
                        ? [DoctorXColors.error.withOpacity(0.2), DoctorXColors.error.withOpacity(0.05)]
                        : [DoctorXColors.primary.withOpacity(0.2), DoctorXColors.primary.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      request.patientName.substring(0, 1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUrgent ? DoctorXColors.error : DoctorXColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.patientName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('ID: ${request.id}', style: TextStyle(color: DoctorXColors.outline, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: (isUrgent ? DoctorXColors.error : DoctorXColors.pending).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isUrgent ? 'URGENT' : 'ROUTINE',
                    style: TextStyle(
                      color: isUrgent ? DoctorXColors.error : DoctorXColors.onSurfaceVariant,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoTag(Icons.biotech_outlined, request.testNames.first),
                _buildInfoTag(Icons.person_outline, request.doctorName),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: DoctorXColors.outlineVariant),
                    ),
                    child: const Center(
                      child: Text('DECLINE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: DoctorXColors.error)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: DoctorXColors.clinicalGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: DoctorXColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: const Center(
                      child: Text('ACCEPT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: DoctorXColors.outline),
        const SizedBox(width: 4),
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: DoctorXColors.outline),
        ),
      ],
    );
  }
}
