import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../providers/app_provider.dart';
import '../providers/export_provider.dart';
import '../utils/constants.dart';
import '../widgets/add_medicine_dialog.dart';

class FamilyMemberScreen extends ConsumerWidget {
  final String memberId;

  const FamilyMemberScreen({
    Key? key,
    required this.memberId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyMembersAsync = ref.watch(familyMembersNotifierProvider);
    final medicinesAsync = ref.watch(medicinesNotifierProvider);

    return familyMembersAsync.when(
      data: (members) {
        final member = members.firstWhere(
          (m) => m.id == memberId,
          orElse: () => throw Exception('Member not found'),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(member.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => ref
                    .read(exportNotifierProvider.notifier)
                    .exportMemberReport(member.id),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Show edit member dialog
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Family Member'),
                      content: Text(
                        'Are you sure you want to delete ${member.name}? This action cannot be undone.',
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
                        .read(familyMembersNotifierProvider.notifier)
                        .deleteFamilyMember(member.id);
                    if (context.mounted) context.go('/');
                  }
                },
              ),
            ],
          ),
          body: medicinesAsync.when(
            data: (medicines) {
              final memberMedicines = medicines
                  .where((m) => m.metadata['familyMemberId'] == member.id)
                  .toList();

              return ListView(
                padding: const EdgeInsets.all(AppTheme.defaultPadding),
                children: [
                  // Member Info Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (member.photoUrl != null)
                            Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(member.photoUrl!),
                              ),
                            ),
                          const SizedBox(height: AppTheme.defaultPadding),
                          Text(
                            'Relationship: ${member.relationship ?? "Not specified"}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (member.notes != null) ...[
                            const SizedBox(height: AppTheme.smallPadding),
                            Text(
                              'Notes:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(member.notes!),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.defaultPadding),
                  // Medicines Section
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppTheme.defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Medicines',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.add),
                                label: const Text('Add Medicine'),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddMedicineDialog(
                                      familyMemberId: member.id,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        if (memberMedicines.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(AppTheme.defaultPadding),
                            child: Center(
                              child: Text('No medicines added yet'),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: memberMedicines.length,
                            itemBuilder: (context, index) {
                              final medicine = memberMedicines[index];
                              return ListTile(
                                title: Text(medicine.name),
                                subtitle: Text(
                                  'Dosage: ${medicine.dosage}\nFrequency: ${medicine.frequency}',
                                ),
                                trailing: Text(
                                  'Stock: ${medicine.currentQuantity}',
                                  style: TextStyle(
                                    color: medicine.currentQuantity <=
                                            medicine.minimumQuantity
                                        ? Colors.red
                                        : null,
                                  ),
                                ),
                                onTap: () =>
                                    context.go('/medicine/${medicine.id}'),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
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