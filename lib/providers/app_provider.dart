import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';

part 'app_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

@riverpod
class FamilyMembersNotifier extends _$FamilyMembersNotifier {
  @override
  Future<List<FamilyMember>> build() async {
    final databaseService = DatabaseService();
    return databaseService.getAllFamilyMembers();
  }

  Future<void> addFamilyMember(FamilyMember member) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.saveFamilyMember(member);
      final updatedMembers = await databaseService.getAllFamilyMembers();
      state = AsyncValue.data(updatedMembers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateFamilyMember(FamilyMember member) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.saveFamilyMember(member);
      final updatedMembers = await databaseService.getAllFamilyMembers();
      state = AsyncValue.data(updatedMembers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteFamilyMember(String id) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.deleteFamilyMember(id);
      final updatedMembers = await databaseService.getAllFamilyMembers();
      state = AsyncValue.data(updatedMembers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> restoreFromBackup(List<FamilyMember> members) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      
      // Clear existing data
      await databaseService.clearFamilyMembers();
      
      // Save restored members
      for (final member in members) {
        await databaseService.saveFamilyMember(member);
      }
      
      final updatedMembers = await databaseService.getAllFamilyMembers();
      state = AsyncValue.data(updatedMembers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

@riverpod
class MedicinesNotifier extends _$MedicinesNotifier {
  @override
  Future<List<Medicine>> build() async {
    final databaseService = DatabaseService();
    return databaseService.getAllMedicines();
  }

  Future<void> addMedicine(Medicine medicine) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.saveMedicine(medicine);
      final updatedMedicines = await databaseService.getAllMedicines();
      state = AsyncValue.data(updatedMedicines);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateMedicine(Medicine medicine) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.saveMedicine(medicine);
      final updatedMedicines = await databaseService.getAllMedicines();
      state = AsyncValue.data(updatedMedicines);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteMedicine(String id) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      await databaseService.deleteMedicine(id);
      final updatedMedicines = await databaseService.getAllMedicines();
      state = AsyncValue.data(updatedMedicines);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> restoreFromBackup(List<Medicine> medicines) async {
    state = const AsyncValue.loading();
    try {
      final databaseService = DatabaseService();
      
      // Clear existing data
      await databaseService.clearMedicines();
      
      // Save restored medicines
      for (final medicine in medicines) {
        await databaseService.saveMedicine(medicine);
      }
      
      final updatedMedicines = await databaseService.getAllMedicines();
      state = AsyncValue.data(updatedMedicines);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
} 