import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SimplifiedUploadPage extends ConsumerWidget {
  const SimplifiedUploadPage({super.key});

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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPatientHeader(context),
                  const SizedBox(height: 32),
                  _buildSectionTitle(l10n.clinicalObservations, Icons.edit_note_rounded),
                  const SizedBox(height: 12),
                  _buildObservationField(context, l10n),
                  const SizedBox(height: 32),
                  _buildSectionTitle(l10n.laboratoryReport, Icons.upload_file_rounded),
                  const SizedBox(height: 12),
                  _buildUploadZone(context, l10n),
                  const SizedBox(height: 40),
                  _buildActionButtons(context, l10n),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AppLocalizations l10n) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white.withOpacity(0.6),
      title: Text(
        l10n.submitLaboratoryResult,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: DoctorXColors.onSurface),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildPatientHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.tokens.radiusXl),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DoctorXColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('SA', style: TextStyle(color: DoctorXColors.primary, fontWeight: FontWeight.w900, fontSize: 18)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Sarah Ahmed', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: -0.5)),
                Text('LIPID PROFILE - #49201', style: TextStyle(color: DoctorXColors.outline, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: DoctorXColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: DoctorXColors.outline),
        ),
      ],
    );
  }

  Widget _buildObservationField(BuildContext context, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.tokens.radiusXl),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        maxLines: 6,
        decoration: InputDecoration(
          hintText: l10n.enterClinicalFindings,
          hintStyle: TextStyle(color: DoctorXColors.outline.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(context.tokens.radiusXl), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildUploadZone(BuildContext context, AppLocalizations l10n) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DoctorXColors.surfaceContainerLow.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: DoctorXColors.primary.withOpacity(0.2), width: 2, style: BorderStyle.solid), // In real app use DottedBorder
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: DoctorXColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cloud_upload_outlined, color: DoctorXColors.primary, size: 32),
          ),
          const SizedBox(height: 16),
          Text(l10n.tapToSelectFile, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 4),
          Text(l10n.maxSizeNotice, style: const TextStyle(color: DoctorXColors.outline, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: DoctorXColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(64),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.submitResult, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5, fontSize: 16)),
              const SizedBox(width: 12),
              const Icon(Icons.check_circle_rounded, size: 24),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(context, l10n.saveDraft, Icons.save_outlined),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryButton(context, l10n.viewTemplate, Icons.description_outlined),
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
        border: Border.all(color: DoctorXColors.outline.withOpacity(0.1)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: DoctorXColors.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.5, color: DoctorXColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
