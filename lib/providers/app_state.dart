import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../services/notification_service.dart';

class AppState extends ChangeNotifier {
  final _medicineBox = Hive.box<Medicine>('medicines');
  final _familyBox = Hive.box<FamilyMember>('family_members');
  final NotificationService _notifications = NotificationService();

  List<Medicine> _medicines = [];
  List<FamilyMember> _familyMembers = [];

  List<Medicine> get medicines => _medicines;
  List<FamilyMember> get familyMembers => _familyMembers;

  AppState() {
    _loadData();
    _notifications.initialize();
  }

  Future<void> _loadData() async {
    _medicines = _medicineBox.values.toList();
    _familyMembers = _familyBox.values.toList();
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async {
    await _medicineBox.put(medicine.id, medicine);
    await _notifications.scheduleMedicineReminder(medicine);
    _medicines.add(medicine);
    notifyListeners();
  }

  Future<void> updateMedicine(Medicine medicine) async {
    await _medicineBox.put(medicine.id, medicine);
    await _notifications.scheduleMedicineReminder(medicine);
    final index = _medicines.indexWhere((m) => m.id == medicine.id);
    if (index != -1) {
      _medicines[index] = medicine;
      notifyListeners();
    }
  }

  Future<void> deleteMedicine(String id) async {
    await _medicineBox.delete(id);
    await _notifications.cancelMedicineReminder(id);
    _medicines.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  Future<void> addFamilyMember(FamilyMember member) async {
    await _familyBox.put(member.id, member);
    _familyMembers.add(member);
    notifyListeners();
  }

  Future<void> updateFamilyMember(FamilyMember member) async {
    await _familyBox.put(member.id, member);
    final index = _familyMembers.indexWhere((m) => m.id == member.id);
    if (index != -1) {
      _familyMembers[index] = member;
      notifyListeners();
    }
  }

  Future<void> deleteFamilyMember(String id) async {
    await _familyBox.delete(id);
    _familyMembers.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  List<Medicine> getMedicinesForFamily(String familyId) => 
    _medicines.where((m) => m.familyMemberId == familyId).toList();
}

