import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DoctorXColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.tokens.spacingMd),
              child: Column(
                children: [
                  _buildSearchBar(context),
                  const SizedBox(height: 16),
                  _buildFilterChips(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.tokens.spacingMd),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return _buildChatTile(
                      context,
                      name: 'Dr. Elena Rodriguez',
                      role: 'Chief Pathologist',
                      message: 'The morphology results for patient #9042 are ready for review.',
                      time: 'Just now',
                      unreadCount: 2,
                      isOnline: true,
                      isUrgent: true,
                    );
                  }
                  if (index == 1) {
                    return _buildChatTile(
                      context,
                      name: 'Dr. Julian Vance',
                      role: 'Cardiologist',
                      message: 'Confirming receiving the fasting lipid panel.',
                      time: '14:20',
                      unreadCount: 0,
                      isOnline: true,
                      isUrgent: false,
                    );
                  }
                  return _buildChatTile(
                    context,
                    name: 'Sarah Mitchell',
                    role: 'Lab Technician',
                    message: 'I have assigned the CBC panel to the hematology unit.',
                    time: '12:05',
                    unreadCount: 0,
                    isOnline: false,
                    isUrgent: false,
                  );
                },
                childCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white.withOpacity(0.6),
      centerTitle: false,
      title: const Text(
        'Clinical Communications',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5, color: DoctorXColors.onSurface),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DoctorXColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit_note_rounded, color: DoctorXColors.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: DoctorXColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(context.tokens.radiusXl),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: DoctorXColors.outline, size: 20),
          const SizedBox(width: 12),
          Text(
            'Search contacts or clinical threads...',
            style: TextStyle(color: DoctorXColors.outline.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final filters = ['ALL', 'ACTIVE', 'URGENT', 'CHANNELS'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = filter == 'ALL';
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? DoctorXColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: isSelected ? null : Border.all(color: DoctorXColors.outline.withOpacity(0.1)),
              boxShadow: isSelected ? [BoxShadow(color: DoctorXColors.primary.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))] : null,
            ),
            child: Text(
              filter,
              style: TextStyle(
                color: isSelected ? Colors.white : DoctorXColors.outline,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context, {
    required String name,
    required String role,
    required String message,
    required String time,
    required int unreadCount,
    required bool isOnline,
    required bool isUrgent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.tokens.radiusXl),
        border: isUrgent ? const Border(left: BorderSide(color: DoctorXColors.error, width: 4)) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [DoctorXColors.primary.withOpacity(0.1), DoctorXColors.primary.withOpacity(0.2)]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(color: DoctorXColors.primary, fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: DoctorXColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: -0.2),
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: DoctorXColors.outline, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  role.toUpperCase(),
                  style: const TextStyle(color: DoctorXColors.primary, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: unreadCount > 0 ? DoctorXColors.onSurface : DoctorXColors.outline,
                    fontSize: 12,
                    fontWeight: unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: DoctorXColors.primary, shape: BoxShape.circle),
              child: Text(
                '$unreadCount',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
              ),
            ),
        ],
      ),
    );
  }
}
