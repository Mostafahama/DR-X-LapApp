import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/spacing.dart';
import '../../../../core/widgets/glass_card.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
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
                  // Period Selector
                  _buildPeriodSelector(context),
                  SizedBox(height: context.tokens.spacingLg),

                  // Key Metrics Bento Grid
                  _buildMetricsGrid(context),
                  SizedBox(height: context.tokens.spacingXl),

                  // Trend Chart
                  _buildSectionHeader(context, 'PERFORMANCE TRENDS', Icons.analytics_rounded),
                  SizedBox(height: context.tokens.spacingMd),
                  _buildTrendChart(context),
                  SizedBox(height: context.tokens.spacingXl),

                  // Test Distribution
                  _buildSectionHeader(context, 'TEST DISTRIBUTION', Icons.pie_chart_rounded),
                  SizedBox(height: context.tokens.spacingMd),
                  _buildDistributionChart(context),
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
          'Analytics',
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
      actions: [
        IconButton(
          icon: const Icon(Icons.ios_share_rounded),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: context.tokens.radiusMd,
      opacity: 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded, size: 18, color: DoctorXColors.primary),
              SizedBox(width: context.tokens.spacingSm),
              Text(
                'Last 30 Days',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: DoctorXColors.outline),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: context.tokens.spacingMd,
      crossAxisSpacing: context.tokens.spacingMd,
      childAspectRatio: 1.4,
      children: [
        _buildMetricCard(context, 'Requests', '3.4k', '+12%', DoctorXColors.primary),
        _buildMetricCard(context, 'Success', '94%', '+2%', DoctorXColors.success),
        _buildMetricCard(context, 'TAT', '42m', '-5m', DoctorXColors.primaryContainer),
        _buildMetricCard(context, 'Urgent', '124', '+8%', DoctorXColors.urgent),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, String trend, Color color) {
    final isPositive = trend.startsWith('+');
    return GlassCard(
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: DoctorXColors.outline,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: DoctorXColors.onSurface,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                size: 14,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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

  Widget _buildTrendChart(BuildContext context) {
    return GlassCard(
      height: 240,
      padding: const EdgeInsets.fromLTRB(10, 24, 24, 16),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.4,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(color: DoctorXColors.outline, fontSize: 10, fontWeight: FontWeight.bold);
                  if (value % 5 == 0) return Text(value.toInt().toString(), style: style);
                  return const SizedBox();
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(5, 4),
                FlSpot(10, 3.5),
                FlSpot(15, 5),
                FlSpot(20, 4.5),
                FlSpot(25, 6),
                FlSpot(30, 5.5),
              ],
              isCurved: true,
              color: DoctorXColors.primary,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    DoctorXColors.primary.withOpacity(0.2),
                    DoctorXColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionChart(BuildContext context) {
    return GlassCard(
      height: 220,
      padding: EdgeInsets.all(context.tokens.spacingMd),
      borderRadius: context.tokens.radiusLg,
      opacity: 0.4,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(color: DoctorXColors.primary, value: 45, radius: 25, showTitle: false),
                  PieChartSectionData(color: DoctorXColors.primaryContainer, value: 25, radius: 22, showTitle: false),
                  PieChartSectionData(color: DoctorXColors.secondary, value: 20, radius: 19, showTitle: false),
                  PieChartSectionData(color: DoctorXColors.outlineVariant, value: 10, radius: 16, showTitle: false),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Hematology', '45%', DoctorXColors.primary),
                _buildLegendItem('Biochemistry', '25%', DoctorXColors.primaryContainer),
                _buildLegendItem('Immunology', '20%', DoctorXColors.secondary),
                _buildLegendItem('Others', '10%', DoctorXColors.outlineVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            percent,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: DoctorXColors.outline),
          ),
        ],
      ),
    );
  }
}
