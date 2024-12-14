import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/search_provider.dart';
import '../services/search_service.dart';
import '../utils/constants.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResultsAsync = ref.watch(searchResultsProvider);
    final filter = ref.watch(searchFilterNotifierProvider);
    final selectedMemberId = ref.watch(selectedFamilyMemberNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.defaultPadding),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search medicines...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => ref
                      .read(searchQueryNotifierProvider.notifier)
                      .updateQuery(value),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.defaultPadding,
                ),
                child: Row(
                  children: [
                    _buildFilterChip(
                      context: context,
                      ref: ref,
                      label: 'All',
                      filter: SearchFilter.all,
                      currentFilter: filter,
                    ),
                    const SizedBox(width: AppTheme.smallPadding),
                    _buildFilterChip(
                      context: context,
                      ref: ref,
                      label: 'Low Stock',
                      filter: SearchFilter.lowStock,
                      currentFilter: filter,
                    ),
                    const SizedBox(width: AppTheme.smallPadding),
                    _buildFilterChip(
                      context: context,
                      ref: ref,
                      label: 'Expiring Soon',
                      filter: SearchFilter.expiringSoon,
                      currentFilter: filter,
                    ),
                    const SizedBox(width: AppTheme.smallPadding),
                    _buildFamilyMemberFilter(context, ref, selectedMemberId),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.smallPadding),
            ],
          ),
        ),
      ),
      body: searchResultsAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return const Center(
              child: Text('No medicines found'),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            itemBuilder: (context, index) {
              final result = results[index];
              return Card(
                child: ListTile(
                  title: Text(result.medicine.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Dosage: ${result.medicine.dosage}\nFrequency: ${result.medicine.frequency}'),
                      Text(
                        'Family Member: ${result.familyMember.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Stock: ${result.medicine.currentQuantity}',
                        style: TextStyle(
                          color: result.medicine.currentQuantity <=
                                  result.medicine.minimumQuantity
                              ? Colors.red
                              : null,
                        ),
                      ),
                      if (result.medicine.expiryDate != null)
                        Text(
                          'Expires: ${result.medicine.expiryDate!.toString().split(' ')[0]}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  onTap: () => context.go('/medicine/${result.medicine.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required SearchFilter filter,
    required SearchFilter currentFilter,
  }) {
    return FilterChip(
      label: Text(label),
      selected: currentFilter == filter,
      onSelected: (selected) {
        if (selected) {
          ref.read(searchFilterNotifierProvider.notifier).updateFilter(filter);
          if (filter != SearchFilter.byFamilyMember) {
            ref
                .read(selectedFamilyMemberNotifierProvider.notifier)
                .selectFamilyMember(null);
          }
        } else {
          ref
              .read(searchFilterNotifierProvider.notifier)
              .updateFilter(SearchFilter.all);
        }
      },
    );
  }

  Widget _buildFamilyMemberFilter(
    BuildContext context,
    WidgetRef ref,
    String? selectedMemberId,
  ) {
    return FutureBuilder(
      future: ref.read(familyMembersNotifierProvider.future),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final familyMembers = snapshot.data!;
        return DropdownButton<String?>(
          value: selectedMemberId,
          hint: const Text('Filter by Family Member'),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('All Family Members'),
            ),
            ...familyMembers.map((member) => DropdownMenuItem(
                  value: member.id,
                  child: Text(member.name),
                )),
          ],
          onChanged: (value) {
            ref
                .read(selectedFamilyMemberNotifierProvider.notifier)
                .selectFamilyMember(value);
            if (value != null) {
              ref
                  .read(searchFilterNotifierProvider.notifier)
                  .updateFilter(SearchFilter.byFamilyMember);
            } else {
              ref
                  .read(searchFilterNotifierProvider.notifier)
                  .updateFilter(SearchFilter.all);
            }
          },
        );
      },
    );
  }
}

