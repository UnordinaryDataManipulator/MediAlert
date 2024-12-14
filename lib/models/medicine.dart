import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'medicine.freezed.dart';
part 'medicine.g.dart';

@freezed
class Medicine with _$Medicine {
  @HiveType(typeId: 1)
  const factory Medicine({
    @HiveField(0)
    required String id,
    
    @HiveField(1)
    required String name,
    
    @HiveField(2)
    required String dosage,
    
    @HiveField(3)
    required String frequency,
    
    @HiveField(4)
    DateTime? expiryDate,
    
    @HiveField(5)
    required int currentQuantity,
    
    @HiveField(6)
    required int minimumQuantity,
    
    @HiveField(7)
    String? instructions,
    
    @HiveField(8)
    String? barcode,
    
    @HiveField(9)
    String? imageUrl,
    
    @HiveField(10)
    @Default([]) List<DateTime> scheduledTimes,
    
    @HiveField(11)
    @Default({}) Map<String, dynamic> metadata,

    @HiveField(12)
    String? prescriptionPhotoUrl,

    @HiveField(13)
    @Default([]) List<MedicineHistoryEntry> history,
  }) = _Medicine;

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);
}

@freezed
class MedicineHistoryEntry with _$MedicineHistoryEntry {
  @HiveType(typeId: 2)
  const factory MedicineHistoryEntry({
    @HiveField(0)
    required String id,
    
    @HiveField(1)
    required DateTime timestamp,
    
    @HiveField(2)
    required HistoryType type,
    
    @HiveField(3)
    required int quantityChange,
    
    @HiveField(4)
    required int newQuantity,
    
    @HiveField(5)
    String? note,
    
    @HiveField(6)
    required String userId,
    
    @HiveField(7)
    @Default({}) Map<String, dynamic> metadata,
  }) = _MedicineHistoryEntry;

  factory MedicineHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$MedicineHistoryEntryFromJson(json);
}

@HiveType(typeId: 3)
enum HistoryType {
  @HiveField(0)
  intake,
  
  @HiveField(1)
  restock,
  
  @HiveField(2)
  adjustment,
  
  @HiveField(3)
  disposal,
  
  @HiveField(4)
  prescribed,
  
  @HiveField(5)
  other
}

