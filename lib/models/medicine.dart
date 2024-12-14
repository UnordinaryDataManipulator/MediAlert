import 'package:hive/hive.dart';

part 'medicine.g.dart';

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String dosageInstructions;

  @HiveField(3)
  List<String> scheduledTimes;

  @HiveField(4)
  int quantity;

  @HiveField(5)
  int alertThreshold;

  @HiveField(6)
  String familyMemberId;

  Medicine({
    required this.id,
    required this.name,
    required this.dosageInstructions,
    required this.scheduledTimes,
    required this.quantity,
    required this.alertThreshold,
    required this.familyMemberId,
  });

  bool get needsRefill => quantity <= alertThreshold;

  Medicine copyWith({
    String? id,
    String? name,
    String? dosageInstructions,
    List<String>? scheduledTimes,
    int? quantity,
    int? alertThreshold,
    String? familyMemberId,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosageInstructions: dosageInstructions ?? this.dosageInstructions,
      scheduledTimes: scheduledTimes ?? List.from(this.scheduledTimes),
      quantity: quantity ?? this.quantity,
      alertThreshold: alertThreshold ?? this.alertThreshold,
      familyMemberId: familyMemberId ?? this.familyMemberId,
    );
  }
}

