import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctor_x_lab_app/app/theme/colors.dart';
import 'package:doctor_x_lab_app/app/theme/spacing.dart';
import 'package:doctor_x_lab_app/core/widgets/glass_card.dart';
import 'package:doctor_x_lab_app/features/dashboard/presentation/providers/shell_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LabRequestModal extends ConsumerWidget {
  const LabRequestModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: GlassCard(
        borderRadius: context.tokens.radiusLiquid,
        opacity: 0.95,
        padding: EdgeInsets.zero,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, l10n),
                _buildClinicalPrism(context, l10n),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(l10n.requestedPanels, Icons.science_outlined),
                      const SizedBox(height: 12),
                      _buildTestChips([l10n.testCBC, l10n.testLipidProfile, 'HbA1c', 'Metabolic']),
                      const SizedBox(height: 24),
                      _buildSectionHeader(l10n.clinicalNotes, Icons.description_outlined),
                      const SizedBox(height: 12),
                      _buildDoctorNote(context, l10n),
                      const SizedBox(height: 32),
                      _buildActionButtons(context, ref, l10n),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.tokens.radiusLiquid)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [DoctorXColors.error.withOpacity(0.1), DoctorXColors.error.withOpacity(0.2)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: DoctorXColors.error.withOpacity(0.1)),
                ),
                child: const Center(
                  child: Text(
                    'SA',
                    style: TextStyle(color: DoctorXColors.error, fontWeight: FontWeight.w900, fontSize: 22),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: DoctorXColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.patientSarahAhmed,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: -0.5, color: DoctorXColors.onSurface),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildBadge('28Y', const Color(0xFF727687)),
                    const SizedBox(width: 8),
                    _buildBadge(l10n.female, const Color(0xFF727687)),
                    const SizedBox(width: 8),
                    _buildBadge(l10n.urgent, DoctorXColors.error),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF727687)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildClinicalPrism(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [DoctorXColors.primary.withOpacity(0.05), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          _buildInfoItem('ID', '#49201'),
          _buildDivider(),
          _buildInfoItem(l10n.ward, l10n.cardiologyWard),
          _buildDivider(),
          _buildInfoItem(l10n.time, '14:05 (2m ago)'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF727687), letterSpacing: 0.5)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: DoctorXColors.onSurface)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFF727687).withOpacity(0.1),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: DoctorXColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Color(0xFF727687)),
        ),
      ],
    );
  }

  Widget _buildTestChips(List<String> tests) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tests.map((test) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            test,
            style: const TextStyle(color: DoctorXColors.onSurface, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorNote(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DoctorXColors.primary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: DoctorXColors.primary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${l10n.patientNoteSarah}"',
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424656),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(color: DoctorXColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.person, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(l10n.doctorJulianVance, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: DoctorXColors.onSurface)),
              ),
              const Text('Just now', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF727687))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF0052D6), Color(0xFF0066FF)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: const Color(0xFF0052D6).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(shellIndexProvider.notifier).setIndex(1); // Go to Results Queue
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_circle_filled_rounded, size: 24, color: Colors.white),
                const SizedBox(width: 12),
                Text(l10n.startProcessing, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 0.5, fontSize: 16)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(context, l10n.assignTech, Icons.person_add_outlined),
            ),
            const SizedBox(width: 12),
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDAE1FF), width: 1),
              ),
              child: const Icon(Icons.forum_outlined, color: DoctorXColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(BuildContext context, String label, IconData icon) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDAE1FF), width: 1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF424656)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5, color: Color(0xFF424656)),
            ),
          ],
        ),
      ),
    );
  }
}
