import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/cloud_sync_service.dart';
import 'app_provider.dart';

part 'cloud_sync_provider.g.dart';

@riverpod
class CloudSyncNotifier extends _$CloudSyncNotifier {
  @override
  CloudSyncService build() {
    return CloudSyncService();
  }

  Future<void> signIn() async {
    await state.signIn();
  }

  Future<void> signOut() async {
    await state.signOut();
  }

  Future<void> backup() async {
    final medicines = await ref.read(medicinesNotifierProvider.future);
    final familyMembers = await ref.read(familyMembersNotifierProvider.future);
    
    await state.backup(familyMembers, medicines);
    await state.updateLastSyncTime();
  }

  Future<void> restore() async {
    final backupData = await state.restore();
    
    // Update family members
    final familyMembers = (backupData['familyMembers'] as List)
        .map((json) => FamilyMember.fromJson(json))
        .toList();
    await ref
        .read(familyMembersNotifierProvider.notifier)
        .restoreFromBackup(familyMembers);

    // Update medicines
    final medicines = (backupData['medicines'] as List)
        .map((json) => Medicine.fromJson(json))
        .toList();
    await ref
        .read(medicinesNotifierProvider.notifier)
        .restoreFromBackup(medicines);

    await state.updateLastSyncTime();
  }
}

@riverpod
Future<bool> isSignedIn(IsSignedInRef ref) async {
  return ref.watch(cloudSyncNotifierProvider).isSignedIn();
}

@riverpod
Future<DateTime?> lastSyncTime(LastSyncTimeRef ref) async {
  return ref.watch(cloudSyncNotifierProvider).getLastSyncTime();
} 