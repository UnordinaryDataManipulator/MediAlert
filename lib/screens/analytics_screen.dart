import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/analytics_provider.dart';
import '../providers/export_provider.dart';
import '../utils/constants.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsNotifierProvider);
    final medicinesByMemberAsync = ref.watch(medicinesByFamilyMemberProvider);
    final medicinesNeedingAttentionAsync =
        ref.watch(medicinesNeedingAttentionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.file_download),
            onSelected: (value) async {
              switch (value) {
                case 'pdf':
                  await ref.read(exportNotifierProvider.notifier).exportAllToPdf();
                  break;
                case 'csv':
                  await ref.read(exportNotifierProvider.notifier).exportAllToCsv();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'pdf',
                child: ListTile(
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text('Export as PDF'),
                ),
              ),
              const PopupMenuItem(
                value: 'csv',
                child: ListTile(
                  leading: Icon(Icons.table_chart),
                  title: Text('Export as CSV'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(analyticsNotifierProvider);
          ref.invalidate(medicinesByFamilyMemberProvider);
          ref.invalidate(medicinesNeedingAttentionProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.defaultPadding),
          children: [
            // Overview Card
            analyticsAsync.when(
              data: (analytics) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      _buildOverviewGrid(analytics),
                    ],
                  ),
                ),
              ),
              loading: () => const Card(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Card(
                child: Center(child: Text('Error: $error')),
              ),
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            // Medicines by Family Member Chart
            medicinesByMemberAsync.when(
              data: (medicinesByMember) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicines by Family Member',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      SizedBox(
                        height: 200,
                        child: _buildMembersPieChart(medicinesByMember),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const Card(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Card(
                child: Center(child: Text('Error: $error')),
              ),
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            // Medicines Needing Attention
            medicinesNeedingAttentionAsync.when(
              data: (medicinesNeedingAttention) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicines Needing Attention',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      _buildAttentionList(medicinesNeedingAttention),
                    ],
                  ),
                ),
              ),
              loading: () => const Card(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Card(
                child: Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewGrid(MedicineAnalytics analytics) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2,
      children: [
        _buildStatTile(
          'Total Medicines',
          analytics.totalMedicines.toString(),
          Icons.medication,
        ),
        _buildStatTile(
          'Adherence Rate',
          '${analytics.adherenceRate.toStringAsFixed(1)}%',
          Icons.check_circle,
          color: _getAdherenceColor(analytics.adherenceRate),
        ),
        _buildStatTile(
          'Low Stock',
          analytics.lowStockCount.toString(),
          Icons.warning,
          color: analytics.lowStockCount > 0 ? AppTheme.warningColor : null,
        ),
        _buildStatTile(
          'Expiring Soon',
          analytics.expiringCount.toString(),
          Icons.event,
          color: analytics.expiringCount > 0 ? AppTheme.warningColor : null,
        ),
      ],
    );
  }

  Widget _buildStatTile(String title, String value, IconData icon,
      {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildMembersPieChart(Map<String, int> medicinesByMember) {
    if (medicinesByMember.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final total = medicinesByMember.values.reduce((a, b) => a + b);
    final sections = medicinesByMember.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key}\n${percentage.toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 0,
      ),
    );
  }

  Widget _buildAttentionList(Map<String, List<Medicine>> medicinesNeedingAttention) {
    if (medicinesNeedingAttention.values.every((list) => list.isEmpty)) {
      return const Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Center(child: Text('No medicines need attention')),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (medicinesNeedingAttention['lowStock']!.isNotEmpty) ...[
          const Text(
            'Low Stock',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.warningColor,
            ),
          ),
          const SizedBox(height: AppTheme.smallPadding),
          ...medicinesNeedingAttention['lowStock']!.map((medicine) => ListTile(
                title: Text(medicine.name),
                subtitle: Text('Current stock: ${medicine.currentQuantity}'),
                leading: const Icon(Icons.warning, color: AppTheme.warningColor),
              )),
          const SizedBox(height: AppTheme.defaultPadding),
        ],
        if (medicinesNeedingAttention['expiring']!.isNotEmpty) ...[
          const Text(
            'Expiring Soon',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.warningColor,
            ),
          ),
          const SizedBox(height: AppTheme.smallPadding),
          ...medicinesNeedingAttention['expiring']!.map((medicine) => ListTile(
                title: Text(medicine.name),
                subtitle: Text(
                  'Expires: ${medicine.expiryDate.toString().split(' ')[0]}',
                ),
                leading: const Icon(Icons.event, color: AppTheme.warningColor),
              )),
        ],
      ],
    );
  }

  Color _getAdherenceColor(double adherenceRate) {
    if (adherenceRate >= 90) {
      return Colors.green;
    } else if (adherenceRate >= 75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

