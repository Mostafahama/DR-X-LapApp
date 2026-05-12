import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctor_x_lab_app/app/theme/colors.dart';
import 'package:doctor_x_lab_app/app/theme/spacing.dart';
import 'package:doctor_x_lab_app/core/widgets/glass_card.dart';
import 'package:doctor_x_lab_app/app/providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/lab_request_modal.dart';
import '../../../profile/presentation/widgets/profile_modal.dart';

class RequestsDashboardPage extends ConsumerWidget {
  const RequestsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: DoctorXColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, ref, l10n),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.tokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBentoStats(context, l10n),
                  SizedBox(height: context.tokens.spacingLg),
                  _buildTableSection(context, l10n),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final locale = ref.watch(localeProvider);
    final isAr = locale.languageCode == 'ar';

    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white.withOpacity(0.6),
      centerTitle: false,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            l10n.laboratoryRequests,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.5,
              color: DoctorXColors.onSurface,
            ),
          ),
          const SizedBox(width: 12),
          _buildLanguageToggle(ref, isAr),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.3),
                builder: (context) => const ProfileModal(),
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))
                ],
                image: const DecorationImage(
                  image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageToggle(WidgetRef ref, bool isAr) {
    return GestureDetector(
      onTap: () {
        ref.read(localeProvider.notifier).state = isAr ? const Locale('en') : const Locale('ar');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: DoctorXColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: DoctorXColors.primary.withOpacity(0.2)),
        ),
        child: Text(
          isAr ? 'EN' : 'ع',
          style: const TextStyle(
            color: DoctorXColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildBentoStats(BuildContext context, AppLocalizations l10n) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardWidth = (constraints.maxWidth - context.tokens.spacingMd) / 2;
      // Fixed height for cards to prevent overflow
      final cardHeight = cardWidth * 0.55; 
      
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: cardHeight,
              child: _buildStatCard(context, label: l10n.activeTasks, value: '24', icon: Icons.biotech_outlined, color: DoctorXColors.primary),
            ),
          ),
          SizedBox(width: context.tokens.spacingMd),
          Expanded(
            child: SizedBox(
              height: cardHeight,
              child: _buildStatCard(context, label: l10n.urgent, value: '03', icon: Icons.priority_high_rounded, color: DoctorXColors.error),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStatCard(BuildContext context, {required String label, required String value, required IconData icon, required Color color}) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      borderRadius: context.tokens.radiusXl,
      opacity: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(), 
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Color(0xFF727687)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: color, letterSpacing: -1, height: 1)),
              Icon(icon, color: color.withOpacity(0.2), size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableSection(BuildContext context, AppLocalizations l10n) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: context.tokens.radiusLiquid,
      opacity: 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSearchField(context, l10n),
                const SizedBox(height: 12),
                _buildFilterRow(context, l10n),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTableHeader(l10n),
                  const SizedBox(height: 8),
                  _buildRow(context, l10n.patientSarahAhmed, 'SA', l10n.doctorJulianVance, l10n.testLipidProfile, l10n.routine, DoctorXColors.primary, true),
                  const SizedBox(height: 8),
                  _buildRow(context, l10n.patientMarcusKnight, 'MK', l10n.doctorEmilyStone, l10n.testCBC, l10n.urgent, DoctorXColors.error, false),
                  const SizedBox(height: 8),
                  _buildRow(context, l10n.patientLeilaLopez, 'LL', l10n.doctorJulianVance, l10n.testThyroidPanel, l10n.routine, DoctorXColors.primary, false),
                ],
              ),
            ),
          ),
          _buildPagination(context, l10n),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: l10n.searchPatient,
          hintStyle: const TextStyle(color: Color(0xFF727687), fontSize: 13, fontWeight: FontWeight.w600),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF727687)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        _buildSmallButton(context, Icons.filter_list_rounded, l10n.filter),
      ],
    );
  }

  Widget _buildTableHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 150, child: _TableHeader(label: l10n.patientName)),
          SizedBox(width: 120, child: _TableHeader(label: l10n.doctor)),
          SizedBox(width: 120, child: _TableHeader(label: l10n.testPanel)),
          SizedBox(width: 90, child: _TableHeader(label: l10n.priority)),
          SizedBox(width: 80, child: _TableHeader(label: l10n.actions)),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String name, String initials, String doctor, String panel, String priorityLabel, Color priorityColor, bool hasEyeBlue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: DoctorXColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                    child: Center(child: Text(initials, style: const TextStyle(color: DoctorXColors.primary, fontWeight: FontWeight.w900, fontSize: 11))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13), overflow: TextOverflow.ellipsis),
                        const Text('ID: #49201', style: TextStyle(color: Color(0xFF727687), fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.split(' ')[0], style: const TextStyle(color: Color(0xFF424656), fontSize: 11, fontWeight: FontWeight.w600)),
                  Text(doctor.split(' ').sublist(1).join(' '), style: const TextStyle(color: Color(0xFF424656), fontSize: 11, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: DoctorXColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(4)),
                child: Text(panel, style: const TextStyle(color: DoctorXColors.primary, fontSize: 9, fontWeight: FontWeight.w900), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(
              width: 90,
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: priorityColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(priorityLabel, style: TextStyle(color: priorityColor, fontWeight: FontWeight.w900, fontSize: 10)),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(child: _buildEyeButton(context, hasEyeBlue)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEyeButton(BuildContext context, bool isBlue) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.3),
          builder: (context) => const LabRequestModal(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isBlue ? Border.all(color: DoctorXColors.primary, width: 1.5) : Border.all(color: const Color(0xFFDAE1FF), width: 1),
          boxShadow: isBlue ? [BoxShadow(color: DoctorXColors.primary.withOpacity(0.2), blurRadius: 8)] : null,
        ),
        child: Icon(Icons.visibility_outlined, size: 18, color: isBlue ? DoctorXColors.primary : const Color(0xFF727687)),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.showingRequests('3', '24'), 
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF727687)),
          ),
          Row(
            children: [
              const Icon(Icons.chevron_left_rounded, size: 18, color: Color(0xFF727687)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  l10n.pageCount('1', '8'), 
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: DoctorXColors.onSurface.withOpacity(0.8)),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF727687)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF424656)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF424656), letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String label;
  const _TableHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Color(0xFF727687)));
  }
}
