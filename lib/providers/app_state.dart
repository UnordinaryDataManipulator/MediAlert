import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../services/export_service.dart';
import '../services/reminder_service.dart';
import '../services/barcode_service.dart';
import '../services/cloud_sync_service.dart';

class AppState extends ChangeNotifier {
  late Box<FamilyMember> _familyMembersBox;
  late Box<Medicine> _medicinesBox;
  final ExportService _exportService = ExportService();
  final ReminderService _reminderService = ReminderService();
  final BarcodeService _barcodeService = BarcodeService();
  final CloudSyncService _cloudSyncService = CloudSyncService();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  AppState() {
    _initHive();
    _reminderService.initialize();
  }

  // ... (keep existing methods)

  void addMedicine(Medicine medicine) {
    _medicinesBox.add(medicine);
    _reminderService.scheduleMedicineReminder(medicine);
    notifyListeners();
  }

  void updateMedicine(Medicine medicine) {
    medicine.save();
    _reminderService.scheduleMedicineReminder(medicine);
    notifyListeners();
  }

  // ... (keep other existing methods)
}

