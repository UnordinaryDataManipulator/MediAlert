// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Medicine _$MedicineFromJson(Map<String, dynamic> json) {
  return _Medicine.fromJson(json);
}

/// @nodoc
mixin _$Medicine {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get dosage => throw _privateConstructorUsedError;
  @HiveField(3)
  String get frequency => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  @HiveField(5)
  int get currentQuantity => throw _privateConstructorUsedError;
  @HiveField(6)
  int get minimumQuantity => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get instructions => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get barcode => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get imageUrl => throw _privateConstructorUsedError;
  @HiveField(10)
  List<DateTime> get scheduledTimes => throw _privateConstructorUsedError;
  @HiveField(11)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Medicine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicineCopyWith<Medicine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicineCopyWith<$Res> {
  factory $MedicineCopyWith(Medicine value, $Res Function(Medicine) then) =
      _$MedicineCopyWithImpl<$Res, Medicine>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String dosage,
      @HiveField(3) String frequency,
      @HiveField(4) DateTime? expiryDate,
      @HiveField(5) int currentQuantity,
      @HiveField(6) int minimumQuantity,
      @HiveField(7) String? instructions,
      @HiveField(8) String? barcode,
      @HiveField(9) String? imageUrl,
      @HiveField(10) List<DateTime> scheduledTimes,
      @HiveField(11) Map<String, dynamic> metadata});
}

/// @nodoc
class _$MedicineCopyWithImpl<$Res, $Val extends Medicine>
    implements $MedicineCopyWith<$Res> {
  _$MedicineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dosage = null,
    Object? frequency = null,
    Object? expiryDate = freezed,
    Object? currentQuantity = null,
    Object? minimumQuantity = null,
    Object? instructions = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? scheduledTimes = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      minimumQuantity: null == minimumQuantity
          ? _value.minimumQuantity
          : minimumQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledTimes: null == scheduledTimes
          ? _value.scheduledTimes
          : scheduledTimes // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicineImplCopyWith<$Res>
    implements $MedicineCopyWith<$Res> {
  factory _$$MedicineImplCopyWith(
          _$MedicineImpl value, $Res Function(_$MedicineImpl) then) =
      __$$MedicineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String dosage,
      @HiveField(3) String frequency,
      @HiveField(4) DateTime? expiryDate,
      @HiveField(5) int currentQuantity,
      @HiveField(6) int minimumQuantity,
      @HiveField(7) String? instructions,
      @HiveField(8) String? barcode,
      @HiveField(9) String? imageUrl,
      @HiveField(10) List<DateTime> scheduledTimes,
      @HiveField(11) Map<String, dynamic> metadata});
}

/// @nodoc
class __$$MedicineImplCopyWithImpl<$Res>
    extends _$MedicineCopyWithImpl<$Res, _$MedicineImpl>
    implements _$$MedicineImplCopyWith<$Res> {
  __$$MedicineImplCopyWithImpl(
      _$MedicineImpl _value, $Res Function(_$MedicineImpl) _then)
      : super(_value, _then);

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dosage = null,
    Object? frequency = null,
    Object? expiryDate = freezed,
    Object? currentQuantity = null,
    Object? minimumQuantity = null,
    Object? instructions = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? scheduledTimes = null,
    Object? metadata = null,
  }) {
    return _then(_$MedicineImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      minimumQuantity: null == minimumQuantity
          ? _value.minimumQuantity
          : minimumQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledTimes: null == scheduledTimes
          ? _value._scheduledTimes
          : scheduledTimes // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _$MedicineImpl with DiagnosticableTreeMixin implements _Medicine {
  const _$MedicineImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.dosage,
      @HiveField(3) required this.frequency,
      @HiveField(4) this.expiryDate,
      @HiveField(5) required this.currentQuantity,
      @HiveField(6) required this.minimumQuantity,
      @HiveField(7) this.instructions,
      @HiveField(8) this.barcode,
      @HiveField(9) this.imageUrl,
      @HiveField(10) final List<DateTime> scheduledTimes = const [],
      @HiveField(11) final Map<String, dynamic> metadata = const {}})
      : _scheduledTimes = scheduledTimes,
        _metadata = metadata;

  factory _$MedicineImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicineImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String dosage;
  @override
  @HiveField(3)
  final String frequency;
  @override
  @HiveField(4)
  final DateTime? expiryDate;
  @override
  @HiveField(5)
  final int currentQuantity;
  @override
  @HiveField(6)
  final int minimumQuantity;
  @override
  @HiveField(7)
  final String? instructions;
  @override
  @HiveField(8)
  final String? barcode;
  @override
  @HiveField(9)
  final String? imageUrl;
  final List<DateTime> _scheduledTimes;
  @override
  @JsonKey()
  @HiveField(10)
  List<DateTime> get scheduledTimes {
    if (_scheduledTimes is EqualUnmodifiableListView) return _scheduledTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduledTimes);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  @HiveField(11)
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Medicine(id: $id, name: $name, dosage: $dosage, frequency: $frequency, expiryDate: $expiryDate, currentQuantity: $currentQuantity, minimumQuantity: $minimumQuantity, instructions: $instructions, barcode: $barcode, imageUrl: $imageUrl, scheduledTimes: $scheduledTimes, metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Medicine'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dosage', dosage))
      ..add(DiagnosticsProperty('frequency', frequency))
      ..add(DiagnosticsProperty('expiryDate', expiryDate))
      ..add(DiagnosticsProperty('currentQuantity', currentQuantity))
      ..add(DiagnosticsProperty('minimumQuantity', minimumQuantity))
      ..add(DiagnosticsProperty('instructions', instructions))
      ..add(DiagnosticsProperty('barcode', barcode))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('scheduledTimes', scheduledTimes))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity) &&
            (identical(other.minimumQuantity, minimumQuantity) ||
                other.minimumQuantity == minimumQuantity) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._scheduledTimes, _scheduledTimes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dosage,
      frequency,
      expiryDate,
      currentQuantity,
      minimumQuantity,
      instructions,
      barcode,
      imageUrl,
      const DeepCollectionEquality().hash(_scheduledTimes),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineImplCopyWith<_$MedicineImpl> get copyWith =>
      __$$MedicineImplCopyWithImpl<_$MedicineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicineImplToJson(
      this,
    );
  }
}

abstract class _Medicine implements Medicine {
  const factory _Medicine(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String dosage,
      @HiveField(3) required final String frequency,
      @HiveField(4) final DateTime? expiryDate,
      @HiveField(5) required final int currentQuantity,
      @HiveField(6) required final int minimumQuantity,
      @HiveField(7) final String? instructions,
      @HiveField(8) final String? barcode,
      @HiveField(9) final String? imageUrl,
      @HiveField(10) final List<DateTime> scheduledTimes,
      @HiveField(11) final Map<String, dynamic> metadata}) = _$MedicineImpl;

  factory _Medicine.fromJson(Map<String, dynamic> json) =
      _$MedicineImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get dosage;
  @override
  @HiveField(3)
  String get frequency;
  @override
  @HiveField(4)
  DateTime? get expiryDate;
  @override
  @HiveField(5)
  int get currentQuantity;
  @override
  @HiveField(6)
  int get minimumQuantity;
  @override
  @HiveField(7)
  String? get instructions;
  @override
  @HiveField(8)
  String? get barcode;
  @override
  @HiveField(9)
  String? get imageUrl;
  @override
  @HiveField(10)
  List<DateTime> get scheduledTimes;
  @override
  @HiveField(11)
  Map<String, dynamic> get metadata;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicineImplCopyWith<_$MedicineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
