import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../requests/data/models/lab_request_model.dart';

class UploadResultsPage extends ConsumerStatefulWidget {
  final LabRequest request;

  const UploadResultsPage({super.key, required this.request});

  @override
  ConsumerState<UploadResultsPage> createState() => _UploadResultsPageState();
}

class _UploadResultsPageState extends ConsumerState<UploadResultsPage> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  // Patient Summary Card
                  _buildPatientContext(context),
                  SizedBox(height: context.tokens.spacingLg),

                  // Laboratory Notes
                  _buildSectionHeader(context, 'LABORATORY OBSERVATIONS', Icons.edit_note_rounded),
                  SizedBox(height: context.tokens.spacingMd),
                  _buildNotesArea(context),
                  SizedBox(height: context.tokens.spacingLg),

                  // Upload Zone
                  _buildSectionHeader(context, 'RESULT DOCUMENTATION', Icons.cloud_upload_rounded),
                  SizedBox(height: context.tokens.spacingMd),
                  _buildUploadZone(context),
                  SizedBox(height: context.tokens.spacingXxl),

                  // Submission Actions
                  _buildActionButtons(context),
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
          'Upload Result',
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
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline_rounded),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPatientContext(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.8,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: DoctorXColors.primary.withOpacity(0.1),
            child: Text(
              widget.request.patientName.substring(0, 2).toUpperCase(),
              style: const TextStyle(
                color: DoctorXColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: context.tokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.request.patientName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  'ID: ${widget.request.id.substring(0, 8).toUpperCase()}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: DoctorXColors.outline,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: context.tokens.spacingXs),
                Wrap(
                  spacing: 4,
                  children: widget.request.testNames.map((test) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: DoctorXColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      test,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: DoctorXColors.primary,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: DoctorXColors.primary),
        SizedBox(width: context.tokens.spacingSm),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: DoctorXColors.outline,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
        ),
      ],
    );
  }

  Widget _buildNotesArea(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusMd,
      opacity: 0.6,
      child: TextField(
        controller: _notesController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Enter clinical findings and specialist observations...',
          hintStyle: TextStyle(color: DoctorXColors.outline.withOpacity(0.5), fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildUploadZone(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GlassCard(
        padding: EdgeInsets.all(context.tokens.spacingXl),
        borderRadius: context.tokens.radiusLg,
        opacity: 0.4,
        border: Border.all(color: DoctorXColors.primary.withOpacity(0.2), width: 2),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: DoctorXColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.upload_file_rounded,
                size: 32,
                color: DoctorXColors.primary,
              ),
            ),
            SizedBox(height: context.tokens.spacingMd),
            Text(
              'Select Report File',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'PDF, JPEG, or DICOM supported',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: DoctorXColors.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () => context.pop(),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            backgroundColor: DoctorXColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.tokens.radiusMd),
            ),
            elevation: 8,
            shadowColor: DoctorXColors.primary.withOpacity(0.3),
          ),
          child: const Text(
            'SUBMIT FINAL REPORT',
            style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
        ),
        SizedBox(height: context.tokens.spacingMd),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  side: BorderSide(color: DoctorXColors.primary.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.tokens.radiusMd),
                  ),
                ),
                child: const Text(
                  'SAVE DRAFT',
                  style: TextStyle(fontWeight: FontWeight.bold, color: DoctorXColors.primary),
                ),
              ),
            ),
            SizedBox(width: context.tokens.spacingMd),
            Expanded(
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: DoctorXColors.secondaryContainer,
                  foregroundColor: DoctorXColors.onSecondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.tokens.radiusMd),
                  ),
                ),
                child: const Text(
                  'MARK READY',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
