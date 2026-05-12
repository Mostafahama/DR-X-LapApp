import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';

class TestCatalogPage extends ConsumerWidget {
  const TestCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(context.tokens.spacingMd),
        children: [
          // Search
          TextField(
            decoration: InputDecoration(
              hintText: 'Search tests...',
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          SizedBox(height: context.tokens.spacingLg),

          _buildTestCard(context, 'Complete Blood Count (CBC)', '12 Parameters',
              '\$45.00'),
          SizedBox(height: context.tokens.spacingMd),
          _buildTestCard(context, 'Lipid Profile', '5 Parameters', '\$30.00'),
          SizedBox(height: context.tokens.spacingMd),
          _buildTestCard(context, 'Thyroid Panel', '3 Parameters', '\$55.00'),
          SizedBox(height: context.tokens.spacingMd),
          _buildTestCard(context, 'Comprehensive Metabolic Panel',
              '14 Parameters', '\$80.00'),
        ],
      ),
    );
  }

  Widget _buildTestCard(
      BuildContext context, String title, String params, String price) {
    return Container(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      decoration: BoxDecoration(
        color: DoctorXColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.tokens.radiusMd),
        border:
            Border.all(color: DoctorXColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                price,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: DoctorXColors.primary),
              ),
            ],
          ),
          SizedBox(height: context.tokens.spacingSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                params,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: DoctorXColors.outline),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit_outlined,
                        size: 20, color: DoctorXColors.secondary),
                    onPressed: () {},
                  ),
                  SizedBox(width: context.tokens.spacingMd),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline,
                        size: 20, color: DoctorXColors.error),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
