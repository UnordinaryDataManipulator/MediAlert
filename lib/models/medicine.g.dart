// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineImplAdapter extends TypeAdapter<_$MedicineImpl> {
  @override
  final int typeId = 1;

  @override
  _$MedicineImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$MedicineImpl(
      id: fields[0] as String,
      name: fields[1] as String,
      dosage: fields[2] as String,
      frequency: fields[3] as String,
      expiryDate: fields[4] as DateTime?,
      currentQuantity: fields[5] as int,
      minimumQuantity: fields[6] as int,
      instructions: fields[7] as String?,
      barcode: fields[8] as String?,
      imageUrl: fields[9] as String?,
      scheduledTimes: (fields[10] as List).cast<DateTime>(),
      metadata: (fields[11] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$MedicineImpl obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.frequency)
      ..writeByte(4)
      ..write(obj.expiryDate)
      ..writeByte(5)
      ..write(obj.currentQuantity)
      ..writeByte(6)
      ..write(obj.minimumQuantity)
      ..writeByte(7)
      ..write(obj.instructions)
      ..writeByte(8)
      ..write(obj.barcode)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.scheduledTimes)
      ..writeByte(11)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicineImpl _$$MedicineImplFromJson(Map<String, dynamic> json) =>
    _$MedicineImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      currentQuantity: (json['currentQuantity'] as num).toInt(),
      minimumQuantity: (json['minimumQuantity'] as num).toInt(),
      instructions: json['instructions'] as String?,
      barcode: json['barcode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      scheduledTimes: (json['scheduledTimes'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MedicineImplToJson(_$MedicineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'currentQuantity': instance.currentQuantity,
      'minimumQuantity': instance.minimumQuantity,
      'instructions': instance.instructions,
      'barcode': instance.barcode,
      'imageUrl': instance.imageUrl,
      'scheduledTimes':
          instance.scheduledTimes.map((e) => e.toIso8601String()).toList(),
      'metadata': instance.metadata,
    };
