import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/export_service.dart';
import 'app_provider.dart';

part 'export_provider.g.dart';

@riverpod
class ExportNotifier extends _$ExportNotifier {
  @override
  ExportService build() {
    return ExportService();
  }

  Future<void> exportAllToPdf() async {
    final medicines = await ref.read(medicinesNotifierProvider.future);
    final familyMembers = await ref.read(familyMembersNotifierProvider.future);
    
    await state.exportToPdf(
      familyMembers: familyMembers,
      medicines: medicines,
    );
  }

  Future<void> exportAllToCsv() async {
    final medicines = await ref.read(medicinesNotifierProvider.future);
    final familyMembers = await ref.read(familyMembersNotifierProvider.future);
    
    await state.exportToCsv(
      familyMembers: familyMembers,
      medicines: medicines,
    );
  }

  Future<void> exportMemberReport(String memberId) async {
    final medicines = await ref.read(medicinesNotifierProvider.future);
    final familyMembers = await ref.read(familyMembersNotifierProvider.future);
    
    final member = familyMembers.firstWhere(
      (m) => m.id == memberId,
      orElse: () => throw Exception('Member not found'),
    );
    
    await state.exportMemberReport(member, medicines);
  }
} 