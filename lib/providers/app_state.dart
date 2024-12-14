import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

class AppState extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final NotificationService _notificationService = NotificationService();

  List<FamilyMember> _familyMembers = [];
  List<Medicine> _medicines = [];

  List<FamilyMember> get familyMembers => _familyMembers;
  List<Medicine> get medicines => _medicines;

  AppState() {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _databaseService.initialize();
    await _loadData();
    notifyListeners();
  }

  Future<void> _loadData() async {
    _familyMembers = await _databaseService.getFamilyMembers();
    _medicines = await _databaseService.getMedicines();
  }

  // Rest of your AppState implementation...
}

