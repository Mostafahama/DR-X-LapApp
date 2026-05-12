import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';

class ChatOverlay extends StatelessWidget {
  final String name;
  final String role;
  final bool isOnline;

  const ChatOverlay({
    super.key,
    required this.name,
    required this.role,
    this.isOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(top: 60), // Positioned below main app bar
      child: GlassCard(
        borderRadius: 32,
        opacity: 0.95,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _buildHeader(context, l10n),
            Expanded(child: _buildMessageList(context, l10n)),
            _buildInputArea(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: DoctorXColors.onSurface),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: -0.2),
                ),
                Row(
                  children: [
                    if (isOnline) ...[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: DoctorXColors.success, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.activeNow,
                        style: const TextStyle(color: DoctorXColors.success, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                    ] else ...[
                       Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: DoctorXColors.outline, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'OFFLINE',
                        style: TextStyle(color: DoctorXColors.outline, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          _buildActionIcon(Icons.videocam_outlined),
          const SizedBox(width: 8),
          _buildActionIcon(Icons.info_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Icon(icon, size: 20, color: DoctorXColors.onSurfaceVariant),
    );
  }

  Widget _buildMessageList(BuildContext context, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: DoctorXColors.surfaceContainerLow.withOpacity(0.2),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDateDivider(l10n.today),
          _buildReceivedMessage(
            context,
            'Good morning Dr. Julian. I have reviewed the CBC results for patient #49201.',
            '09:42 AM',
          ),
          _buildReceivedMessage(
            context,
            'The morphology report shows significant indicators in the hematology panel. Please check the attachment.',
            '09:43 AM',
          ),
          _buildSentMessage(
            context,
            'Thank you Elena. I am reviewing the markers now. Should we proceed with the thyroid panel?',
            '09:45 AM',
          ),
          _buildReceivedMessage(
            context,
            'Yes, I recommend it given the fatigue symptoms. I\'ve already signaled the tech.',
            '09:46 AM',
          ),
        ],
      ),
    );
  }

  Widget _buildDateDivider(String date) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          date,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: DoctorXColors.outline, letterSpacing: 1),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 60),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: DoctorXColors.onSurface, height: 1.4),
            ),
            const SizedBox(height: 6),
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: DoctorXColors.outline, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 60),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: DoctorXColors.clinicalGradient,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(color: DoctorXColors.primary.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.done_all_rounded, size: 14, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.2))),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: DoctorXColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: l10n.typeMessage,
                      border: InputBorder.none,
                      hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: DoctorXColors.outline),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  gradient: DoctorXColors.clinicalGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInputTool(Icons.image_outlined, l10n.photos),
              _buildInputTool(Icons.description_outlined, l10n.reports),
              _buildInputTool(Icons.biotech_outlined, l10n.lab),
              _buildInputTool(Icons.mic_none_rounded, l10n.voice),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputTool(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: DoctorXColors.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: DoctorXColors.outline, letterSpacing: 0.5),
        ),
      ],
    );
  }
}
