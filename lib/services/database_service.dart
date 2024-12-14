import 'package:hive_flutter/hive_flutter.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../utils/constants.dart';

class DatabaseService {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(FamilyMemberAdapter());
    Hive.registerAdapter(MedicineAdapter());
    
    // Open boxes
    await Hive.openBox<FamilyMember>(AppConstants.familyMembersBox);
    await Hive.openBox<Medicine>(AppConstants.medicinesBox);
    await Hive.openBox(AppConstants.settingsBox);
  }
  
  // Family Member operations
  Future<List<FamilyMember>> getAllFamilyMembers() async {
    final box = Hive.box<FamilyMember>(AppConstants.familyMembersBox);
    return box.values.toList();
  }
  
  Future<void> saveFamilyMember(FamilyMember member) async {
    final box = Hive.box<FamilyMember>(AppConstants.familyMembersBox);
    await box.put(member.id, member);
  }
  
  Future<void> deleteFamilyMember(String id) async {
    final box = Hive.box<FamilyMember>(AppConstants.familyMembersBox);
    await box.delete(id);
  }

  Future<void> clearFamilyMembers() async {
    final box = Hive.box<FamilyMember>(AppConstants.familyMembersBox);
    await box.clear();
  }
  
  // Medicine operations
  Future<List<Medicine>> getAllMedicines() async {
    final box = Hive.box<Medicine>(AppConstants.medicinesBox);
    return box.values.toList();
  }
  
  Future<List<Medicine>> getMedicinesForFamilyMember(String familyMemberId) async {
    final box = Hive.box<Medicine>(AppConstants.medicinesBox);
    return box.values
        .where((medicine) => medicine.metadata['familyMemberId'] == familyMemberId)
        .toList();
  }
  
  Future<void> saveMedicine(Medicine medicine) async {
    final box = Hive.box<Medicine>(AppConstants.medicinesBox);
    await box.put(medicine.id, medicine);
  }
  
  Future<void> deleteMedicine(String id) async {
    final box = Hive.box<Medicine>(AppConstants.medicinesBox);
    await box.delete(id);
  }

  Future<void> clearMedicines() async {
    final box = Hive.box<Medicine>(AppConstants.medicinesBox);
    await box.clear();
  }
  
  // Settings operations
  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(AppConstants.settingsBox);
    await box.put(key, value);
  }
  
  Future<T?> getSetting<T>(String key) async {
    final box = Hive.box(AppConstants.settingsBox);
    return box.get(key) as T?;
  }
  
  // Cleanup
  Future<void> clearAllData() async {
    await clearFamilyMembers();
    await clearMedicines();
    await Hive.box(AppConstants.settingsBox).clear();
  }
} 