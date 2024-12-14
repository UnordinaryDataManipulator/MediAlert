// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyMemberImplAdapter extends TypeAdapter<_$FamilyMemberImpl> {
  @override
  final int typeId = 0;

  @override
  _$FamilyMemberImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$FamilyMemberImpl(
      id: fields[0] as String,
      name: fields[1] as String,
      dateOfBirth: fields[2] as DateTime,
      relationship: fields[3] as String?,
      photoUrl: fields[4] as String?,
      isCaregiver: fields[5] as bool,
      notes: fields[6] as String?,
      medicineIds: (fields[7] as List).cast<String>(),
      preferences: (fields[8] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$FamilyMemberImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dateOfBirth)
      ..writeByte(3)
      ..write(obj.relationship)
      ..writeByte(4)
      ..write(obj.photoUrl)
      ..writeByte(5)
      ..write(obj.isCaregiver)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.medicineIds)
      ..writeByte(8)
      ..write(obj.preferences);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyMemberImpl _$$FamilyMemberImplFromJson(Map<String, dynamic> json) =>
    _$FamilyMemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      relationship: json['relationship'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isCaregiver: json['isCaregiver'] as bool? ?? false,
      notes: json['notes'] as String?,
      medicineIds: (json['medicineIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$FamilyMemberImplToJson(_$FamilyMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'relationship': instance.relationship,
      'photoUrl': instance.photoUrl,
      'isCaregiver': instance.isCaregiver,
      'notes': instance.notes,
      'medicineIds': instance.medicineIds,
      'preferences': instance.preferences,
    };
