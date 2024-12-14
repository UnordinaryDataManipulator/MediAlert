import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'family_member.freezed.dart';
part 'family_member.g.dart';

@freezed
class FamilyMember with _$FamilyMember {
  @HiveType(typeId: 0)
  const factory FamilyMember({
    @HiveField(0)
    required String id,
    
    @HiveField(1)
    required String name,
    
    @HiveField(2)
    required DateTime dateOfBirth,
    
    @HiveField(3)
    String? relationship,
    
    @HiveField(4)
    String? photoUrl,
    
    @HiveField(5)
    @Default(false) bool isCaregiver,
    
    @HiveField(6)
    String? notes,
    
    @HiveField(7)
    @Default([]) List<String> medicineIds,
    
    @HiveField(8)
    @Default({}) Map<String, dynamic> preferences,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
}

