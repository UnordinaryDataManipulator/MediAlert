import '../models/medicine.dart';
import '../models/family_member.dart';

class MedicineAnalytics {
  final int totalMedicines;
  final int lowStockCount;
  final int expiringCount;
  final Map<String, int> medicinesByFrequency;
  final double adherenceRate;
  final List<StockHistory> stockHistory;

  MedicineAnalytics({
    required this.totalMedicines,
    required this.lowStockCount,
    required this.expiringCount,
    required this.medicinesByFrequency,
    required this.adherenceRate,
    required this.stockHistory,
  });
}

class StockHistory {
  final DateTime date;
  final int quantity;
  final String medicineName;

  StockHistory({
    required this.date,
    required this.quantity,
    required this.medicineName,
  });
}

class AnalyticsService {
  MedicineAnalytics calculateMedicineAnalytics(
    List<Medicine> medicines,
    List<FamilyMember> familyMembers,
  ) {
    // Calculate total medicines
    final totalMedicines = medicines.length;

    // Calculate low stock count
    final lowStockCount = medicines
        .where((m) => m.currentQuantity <= m.minimumQuantity)
        .length;

    // Calculate expiring medicines count (within 30 days)
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));
    final expiringCount = medicines
        .where((m) =>
            m.expiryDate != null &&
            m.expiryDate!.isAfter(now) &&
            m.expiryDate!.isBefore(thirtyDaysFromNow))
        .length;

    // Calculate medicines by frequency
    final medicinesByFrequency = <String, int>{};
    for (final medicine in medicines) {
      medicinesByFrequency.update(
        medicine.frequency,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    // Calculate adherence rate (based on scheduled times vs current time)
    int totalScheduledDoses = 0;
    int takenDoses = 0;
    for (final medicine in medicines) {
      final scheduledTimes = medicine.scheduledTimes;
      for (final time in scheduledTimes) {
        if (time.isBefore(now)) {
          totalScheduledDoses++;
          // Assuming if the quantity has decreased, the dose was taken
          // This is a simplified calculation and should be improved with actual tracking
          takenDoses++;
        }
      }
    }
    final adherenceRate = totalScheduledDoses > 0
        ? (takenDoses / totalScheduledDoses) * 100
        : 100.0;

    // Create stock history (last 30 days)
    // This is a placeholder - in a real app, you'd track actual stock changes
    final stockHistory = <StockHistory>[];
    for (final medicine in medicines) {
      stockHistory.add(StockHistory(
        date: now,
        quantity: medicine.currentQuantity,
        medicineName: medicine.name,
      ));
    }

    return MedicineAnalytics(
      totalMedicines: totalMedicines,
      lowStockCount: lowStockCount,
      expiringCount: expiringCount,
      medicinesByFrequency: medicinesByFrequency,
      adherenceRate: adherenceRate,
      stockHistory: stockHistory,
    );
  }

  Map<String, int> calculateMedicinesByFamilyMember(
    List<Medicine> medicines,
    List<FamilyMember> familyMembers,
  ) {
    final medicinesByMember = <String, int>{};
    
    for (final member in familyMembers) {
      final count = medicines
          .where((m) => m.metadata['familyMemberId'] == member.id)
          .length;
      medicinesByMember[member.name] = count;
    }

    return medicinesByMember;
  }

  Map<String, List<Medicine>> getMedicinesNeedingAttention(
    List<Medicine> medicines,
  ) {
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));

    return {
      'lowStock': medicines
          .where((m) => m.currentQuantity <= m.minimumQuantity)
          .toList(),
      'expiring': medicines
          .where((m) =>
              m.expiryDate != null &&
              m.expiryDate!.isAfter(now) &&
              m.expiryDate!.isBefore(thirtyDaysFromNow))
          .toList(),
    };
  }
} 