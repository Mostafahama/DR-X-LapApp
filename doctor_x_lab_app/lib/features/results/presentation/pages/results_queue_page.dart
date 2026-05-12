import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_x_lab_app/app/routes/route_names.dart';
import 'package:doctor_x_lab_app/app/theme/colors.dart';
import 'package:doctor_x_lab_app/app/theme/spacing.dart';
import 'package:doctor_x_lab_app/core/widgets/glass_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultsQueuePage extends ConsumerWidget {
  const ResultsQueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: DoctorXColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, l10n),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.tokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetricsGrid(context, l10n),
                  const SizedBox(height: 24),
                  _buildSearchAndFilters(context, l10n),
                  const SizedBox(height: 16),
                  _buildQueueList(context, l10n),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AppLocalizations l10n) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white.withOpacity(0.6),
      centerTitle: false,
      title: Text(
        l10n.resultsQueue,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5, color: DoctorXColors.onSurface),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: DoctorXColors.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.sync_rounded, color: DoctorXColors.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        _buildMetricItem(context, l10n.pending, '08', DoctorXColors.error),
        const SizedBox(width: 12),
        _buildMetricItem(context, l10n.inProgress, '12', DoctorXColors.primary),
        const SizedBox(width: 12),
        _buildMetricItem(context, l10n.validated, '45', DoctorXColors.success),
      ],
    );
  }

  Widget _buildMetricItem(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.tokens.radiusXl),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1, color: Color(0xFF727687))),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color, letterSpacing: -1)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Color(0xFF727687), size: 18),
                const SizedBox(width: 12),
                Text(l10n.searchQueue, style: TextStyle(color: const Color(0xFF727687).withOpacity(0.6), fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDAE1FF)),
          ),
          child: const Icon(Icons.tune_rounded, color: Color(0xFF424656), size: 20),
        ),
      ],
    );
  }

  Widget _buildQueueList(BuildContext context, AppLocalizations l10n) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) return _buildQueueItem(context, l10n.validating, l10n.patientSarahAhmed, '#49201', [l10n.testCBC, l10n.testLipidProfile], l10n.techMarkV, '14:05', DoctorXColors.primary);
        if (index == 1) return _buildQueueItem(context, l10n.ready, l10n.patientMarcusKnight, '#49195', ['HbA1c'], l10n.techElenaR, '13:42', DoctorXColors.success);
        if (index == 2) return _buildQueueItem(context, l10n.inProgress, l10n.patientLeilaLopez, '#49188', [l10n.testThyroidPanel], l10n.doctorJulianVance, '12:15', DoctorXColors.primary);
        return _buildQueueItem(context, l10n.pending, l10n.patientJamesWilson, '#49172', ['Metabolic'], l10n.notAssigned, '11:05', DoctorXColors.error);
      },
    );
  }

  Widget _buildQueueItem(
    BuildContext context,
    String status,
    String patient,
    String id,
    List<String> tests,
    String technician,
    String time,
    Color statusColor,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed(RouteNames.simplifiedUpload),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.tokens.radiusXl),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                ),
                Text(time, style: const TextStyle(color: Color(0xFF727687), fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person_outline_rounded, color: Color(0xFF727687)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patient, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.2)),
                      Text('ID: $id', style: const TextStyle(color: Color(0xFF727687), fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Color(0xFF727687)),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF2F4F6)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    children: tests.map((t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: DoctorXColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(4)),
                      child: Text(t, style: const TextStyle(color: DoctorXColors.primary, fontSize: 9, fontWeight: FontWeight.w900)),
                    )).toList(),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.engineering_outlined, size: 14, color: Color(0xFF727687)),
                    const SizedBox(width: 4),
                    Text(technician, style: const TextStyle(color: Color(0xFF727687), fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
