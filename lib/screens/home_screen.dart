import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import '../widgets/family_member_list.dart';
import '../widgets/medicine_list.dart';
import '../widgets/add_family_member_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyMembers = ref.watch(familyMembersNotifierProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/analytics'),
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: familyMembers.when(
        data: (members) => members.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No family members added yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddFamilyMemberDialog(),
                        );
                      },
                      child: const Text('Add Family Member'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: members.length,
                padding: const EdgeInsets.all(AppTheme.defaultPadding),
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: member.photoUrl != null
                            ? NetworkImage(member.photoUrl!)
                            : null,
                        child: member.photoUrl == null
                            ? Text(member.name[0].toUpperCase())
                            : null,
                      ),
                      title: Text(member.name),
                      subtitle: Text(member.relationship ?? 'Family Member'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go('/family-member/${member.id}'),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddFamilyMemberDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

