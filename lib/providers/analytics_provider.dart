import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/analytics_service.dart';
import '../models/medicine.dart';
import '../models/family_member.dart';
import 'app_provider.dart';

part 'analytics_provider.g.dart';

@riverpod
class AnalyticsNotifier extends _$AnalyticsNotifier {
  @override
  Future<MedicineAnalytics> build() async {
    final analyticsService = AnalyticsService();
    final medicines = await ref.watch(medicinesNotifierProvider.future);
    final familyMembers = await ref.watch(familyMembersNotifierProvider.future);
    
    return analyticsService.calculateMedicineAnalytics(
      medicines,
      familyMembers,
    );
  }
}

@riverpod
Future<Map<String, int>> medicinesByFamilyMember(
  MedicinesByFamilyMemberRef ref,
) async {
  final analyticsService = AnalyticsService();
  final medicines = await ref.watch(medicinesNotifierProvider.future);
  final familyMembers = await ref.watch(familyMembersNotifierProvider.future);
  
  return analyticsService.calculateMedicinesByFamilyMember(
    medicines,
    familyMembers,
  );
}

@riverpod
Future<Map<String, List<Medicine>>> medicinesNeedingAttention(
  MedicinesNeedingAttentionRef ref,
) async {
  final analyticsService = AnalyticsService();
  final medicines = await ref.watch(medicinesNotifierProvider.future);
  
  return analyticsService.getMedicinesNeedingAttention(medicines);
} 