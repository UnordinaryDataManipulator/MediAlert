// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) {
  return _FamilyMember.fromJson(json);
}

/// @nodoc
mixin _$FamilyMember {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get relationship => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get photoUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isCaregiver => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get medicineIds => throw _privateConstructorUsedError;
  @HiveField(8)
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// Serializes this FamilyMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FamilyMemberCopyWith<FamilyMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyMemberCopyWith<$Res> {
  factory $FamilyMemberCopyWith(
          FamilyMember value, $Res Function(FamilyMember) then) =
      _$FamilyMemberCopyWithImpl<$Res, FamilyMember>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) DateTime dateOfBirth,
      @HiveField(3) String? relationship,
      @HiveField(4) String? photoUrl,
      @HiveField(5) bool isCaregiver,
      @HiveField(6) String? notes,
      @HiveField(7) List<String> medicineIds,
      @HiveField(8) Map<String, dynamic> preferences});
}

/// @nodoc
class _$FamilyMemberCopyWithImpl<$Res, $Val extends FamilyMember>
    implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? relationship = freezed,
    Object? photoUrl = freezed,
    Object? isCaregiver = null,
    Object? notes = freezed,
    Object? medicineIds = null,
    Object? preferences = null,
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
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isCaregiver: null == isCaregiver
          ? _value.isCaregiver
          : isCaregiver // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      medicineIds: null == medicineIds
          ? _value.medicineIds
          : medicineIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyMemberImplCopyWith<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  factory _$$FamilyMemberImplCopyWith(
          _$FamilyMemberImpl value, $Res Function(_$FamilyMemberImpl) then) =
      __$$FamilyMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) DateTime dateOfBirth,
      @HiveField(3) String? relationship,
      @HiveField(4) String? photoUrl,
      @HiveField(5) bool isCaregiver,
      @HiveField(6) String? notes,
      @HiveField(7) List<String> medicineIds,
      @HiveField(8) Map<String, dynamic> preferences});
}

/// @nodoc
class __$$FamilyMemberImplCopyWithImpl<$Res>
    extends _$FamilyMemberCopyWithImpl<$Res, _$FamilyMemberImpl>
    implements _$$FamilyMemberImplCopyWith<$Res> {
  __$$FamilyMemberImplCopyWithImpl(
      _$FamilyMemberImpl _value, $Res Function(_$FamilyMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? relationship = freezed,
    Object? photoUrl = freezed,
    Object? isCaregiver = null,
    Object? notes = freezed,
    Object? medicineIds = null,
    Object? preferences = null,
  }) {
    return _then(_$FamilyMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isCaregiver: null == isCaregiver
          ? _value.isCaregiver
          : isCaregiver // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      medicineIds: null == medicineIds
          ? _value._medicineIds
          : medicineIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0)
class _$FamilyMemberImpl with DiagnosticableTreeMixin implements _FamilyMember {
  const _$FamilyMemberImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.dateOfBirth,
      @HiveField(3) this.relationship,
      @HiveField(4) this.photoUrl,
      @HiveField(5) this.isCaregiver = false,
      @HiveField(6) this.notes,
      @HiveField(7) final List<String> medicineIds = const [],
      @HiveField(8) final Map<String, dynamic> preferences = const {}})
      : _medicineIds = medicineIds,
        _preferences = preferences;

  factory _$FamilyMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyMemberImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final DateTime dateOfBirth;
  @override
  @HiveField(3)
  final String? relationship;
  @override
  @HiveField(4)
  final String? photoUrl;
  @override
  @JsonKey()
  @HiveField(5)
  final bool isCaregiver;
  @override
  @HiveField(6)
  final String? notes;
  final List<String> _medicineIds;
  @override
  @JsonKey()
  @HiveField(7)
  List<String> get medicineIds {
    if (_medicineIds is EqualUnmodifiableListView) return _medicineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicineIds);
  }

  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  @HiveField(8)
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FamilyMember(id: $id, name: $name, dateOfBirth: $dateOfBirth, relationship: $relationship, photoUrl: $photoUrl, isCaregiver: $isCaregiver, notes: $notes, medicineIds: $medicineIds, preferences: $preferences)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FamilyMember'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dateOfBirth', dateOfBirth))
      ..add(DiagnosticsProperty('relationship', relationship))
      ..add(DiagnosticsProperty('photoUrl', photoUrl))
      ..add(DiagnosticsProperty('isCaregiver', isCaregiver))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('medicineIds', medicineIds))
      ..add(DiagnosticsProperty('preferences', preferences));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.isCaregiver, isCaregiver) ||
                other.isCaregiver == isCaregiver) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._medicineIds, _medicineIds) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dateOfBirth,
      relationship,
      photoUrl,
      isCaregiver,
      notes,
      const DeepCollectionEquality().hash(_medicineIds),
      const DeepCollectionEquality().hash(_preferences));

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyMemberImplCopyWith<_$FamilyMemberImpl> get copyWith =>
      __$$FamilyMemberImplCopyWithImpl<_$FamilyMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyMemberImplToJson(
      this,
    );
  }
}

abstract class _FamilyMember implements FamilyMember {
  const factory _FamilyMember(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String name,
          @HiveField(2) required final DateTime dateOfBirth,
          @HiveField(3) final String? relationship,
          @HiveField(4) final String? photoUrl,
          @HiveField(5) final bool isCaregiver,
          @HiveField(6) final String? notes,
          @HiveField(7) final List<String> medicineIds,
          @HiveField(8) final Map<String, dynamic> preferences}) =
      _$FamilyMemberImpl;

  factory _FamilyMember.fromJson(Map<String, dynamic> json) =
      _$FamilyMemberImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  DateTime get dateOfBirth;
  @override
  @HiveField(3)
  String? get relationship;
  @override
  @HiveField(4)
  String? get photoUrl;
  @override
  @HiveField(5)
  bool get isCaregiver;
  @override
  @HiveField(6)
  String? get notes;
  @override
  @HiveField(7)
  List<String> get medicineIds;
  @override
  @HiveField(8)
  Map<String, dynamic> get preferences;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FamilyMemberImplCopyWith<_$FamilyMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
