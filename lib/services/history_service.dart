import 'package:uuid/uuid.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';

class HistoryService {
  final DatabaseService _databaseService = DatabaseService();
  final _uuid = const Uuid();

  Future<Medicine> recordIntake({
    required Medicine medicine,
    required String userId,
    required int quantity,
    String? note,
  }) async {
    final entry = MedicineHistoryEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      type: HistoryType.intake,
      quantityChange: -quantity,
      newQuantity: medicine.currentQuantity - quantity,
      note: note,
      userId: userId,
    );

    final updatedMedicine = medicine.copyWith(
      currentQuantity: medicine.currentQuantity - quantity,
      history: [...medicine.history, entry],
    );

    await _databaseService.saveMedicine(updatedMedicine);
    return updatedMedicine;
  }

  Future<Medicine> recordRestock({
    required Medicine medicine,
    required String userId,
    required int quantity,
    String? note,
  }) async {
    final entry = MedicineHistoryEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      type: HistoryType.restock,
      quantityChange: quantity,
      newQuantity: medicine.currentQuantity + quantity,
      note: note,
      userId: userId,
    );

    final updatedMedicine = medicine.copyWith(
      currentQuantity: medicine.currentQuantity + quantity,
      history: [...medicine.history, entry],
    );

    await _databaseService.saveMedicine(updatedMedicine);
    return updatedMedicine;
  }

  Future<Medicine> recordAdjustment({
    required Medicine medicine,
    required String userId,
    required int newQuantity,
    String? note,
  }) async {
    final quantityChange = newQuantity - medicine.currentQuantity;
    final entry = MedicineHistoryEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      type: HistoryType.adjustment,
      quantityChange: quantityChange,
      newQuantity: newQuantity,
      note: note,
      userId: userId,
    );

    final updatedMedicine = medicine.copyWith(
      currentQuantity: newQuantity,
      history: [...medicine.history, entry],
    );

    await _databaseService.saveMedicine(updatedMedicine);
    return updatedMedicine;
  }

  Future<Medicine> recordDisposal({
    required Medicine medicine,
    required String userId,
    required int quantity,
    String? note,
  }) async {
    final entry = MedicineHistoryEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      type: HistoryType.disposal,
      quantityChange: -quantity,
      newQuantity: medicine.currentQuantity - quantity,
      note: note,
      userId: userId,
    );

    final updatedMedicine = medicine.copyWith(
      currentQuantity: medicine.currentQuantity - quantity,
      history: [...medicine.history, entry],
    );

    await _databaseService.saveMedicine(updatedMedicine);
    return updatedMedicine;
  }

  Future<Medicine> recordPrescription({
    required Medicine medicine,
    required String userId,
    required String prescriptionPhotoUrl,
    String? note,
  }) async {
    final entry = MedicineHistoryEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      type: HistoryType.prescribed,
      quantityChange: 0,
      newQuantity: medicine.currentQuantity,
      note: note,
      userId: userId,
      metadata: {
        'prescriptionPhotoUrl': prescriptionPhotoUrl,
      },
    );

    final updatedMedicine = medicine.copyWith(
      prescriptionPhotoUrl: prescriptionPhotoUrl,
      history: [...medicine.history, entry],
    );

    await _databaseService.saveMedicine(updatedMedicine);
    return updatedMedicine;
  }

  List<MedicineHistoryEntry> getHistoryForDateRange({
    required Medicine medicine,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return medicine.history.where((entry) {
      return entry.timestamp.isAfter(startDate) &&
          entry.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  Map<DateTime, List<MedicineHistoryEntry>> getHistoryByDay(Medicine medicine) {
    final Map<DateTime, List<MedicineHistoryEntry>> historyByDay = {};
    
    for (final entry in medicine.history) {
      final date = DateTime(
        entry.timestamp.year,
        entry.timestamp.month,
        entry.timestamp.day,
      );
      
      if (!historyByDay.containsKey(date)) {
        historyByDay[date] = [];
      }
      
      historyByDay[date]!.add(entry);
    }
    
    return historyByDay;
  }

  double calculateAdherenceRate({
    required Medicine medicine,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final intakeEntries = medicine.history.where((entry) {
      return entry.type == HistoryType.intake &&
          entry.timestamp.isAfter(startDate) &&
          entry.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    final expectedDoses = _calculateExpectedDoses(
      medicine.frequency,
      startDate,
      endDate,
    );

    if (expectedDoses == 0) return 1.0;
    return intakeEntries.length / expectedDoses;
  }

  int _calculateExpectedDoses(
    String frequency,
    DateTime startDate,
    DateTime endDate,
  ) {
    final days = endDate.difference(startDate).inDays + 1;
    
    switch (frequency.toLowerCase()) {
      case 'once a day':
        return days;
      case 'twice a day':
        return days * 2;
      case 'three times a day':
        return days * 3;
      case 'every 4 hours':
        return (days * 6).round(); // 24/4 = 6 doses per day
      case 'every 6 hours':
        return (days * 4).round(); // 24/6 = 4 doses per day
      case 'every 8 hours':
        return (days * 3).round(); // 24/8 = 3 doses per day
      case 'every 12 hours':
        return days * 2;
      case 'as needed':
        return 0; // No expected doses for as-needed medications
      default:
        return days; // Default to once a day
    }
  }
} 