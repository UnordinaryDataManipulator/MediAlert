import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/medicine.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';

class MedicineScreen extends ConsumerWidget {
  final String medicineId;

  const MedicineScreen({
    Key? key,
    required this.medicineId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicinesAsync = ref.watch(medicinesNotifierProvider);

    return medicinesAsync.when(
      data: (medicines) {
        final medicine = medicines.firstWhere(
          (m) => m.id == medicineId,
          orElse: () => throw Exception('Medicine not found'),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(medicine.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Show edit medicine dialog
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Medicine'),
                      content: Text(
                        'Are you sure you want to delete ${medicine.name}? This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => context.pop(true),
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (shouldDelete == true) {
                    await ref
                        .read(medicinesNotifierProvider.notifier)
                        .deleteMedicine(medicine.id);
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            children: [
              // Medicine Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (medicine.imageUrl != null)
                        Center(
                          child: Image.network(
                            medicine.imageUrl!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Text(
                        'Dosage',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(medicine.dosage),
                      const SizedBox(height: AppTheme.smallPadding),
                      Text(
                        'Frequency',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(medicine.frequency),
                      if (medicine.instructions != null) ...[
                        const SizedBox(height: AppTheme.smallPadding),
                        Text(
                          'Instructions',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(medicine.instructions!),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              // Inventory Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inventory',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Stock',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                medicine.currentQuantity.toString(),
                                style: TextStyle(
                                  color: medicine.currentQuantity <=
                                          medicine.minimumQuantity
                                      ? Colors.red
                                      : null,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Minimum Stock',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                medicine.minimumQuantity.toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.remove),
                              label: const Text('Decrease'),
                              onPressed: () {
                                // TODO: Show decrease stock dialog
                              },
                            ),
                          ),
                          const SizedBox(width: AppTheme.defaultPadding),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Increase'),
                              onPressed: () {
                                // TODO: Show increase stock dialog
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (medicine.expiryDate != null) ...[
                const SizedBox(height: AppTheme.defaultPadding),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppTheme.smallPadding),
                        Text(
                          medicine.expiryDate.toString().split(' ')[0],
                          style: TextStyle(
                            fontSize: 24,
                            color: medicine.expiryDate!
                                    .isBefore(DateTime.now().add(const Duration(days: 30)))
                                ? Colors.red
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
} 