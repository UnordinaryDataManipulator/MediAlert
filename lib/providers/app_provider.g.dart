// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeNotifierHash() => r'b8a028b728620927f9fb9d31e90385608b4c9254';

/// See also [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeMode>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeMode>;
String _$familyMembersNotifierHash() =>
    r'174d567d35117698e5a04ca43cba20e2c9622c01';

/// See also [FamilyMembersNotifier].
@ProviderFor(FamilyMembersNotifier)
final familyMembersNotifierProvider = AutoDisposeAsyncNotifierProvider<
    FamilyMembersNotifier, List<FamilyMember>>.internal(
  FamilyMembersNotifier.new,
  name: r'familyMembersNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$familyMembersNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FamilyMembersNotifier = AutoDisposeAsyncNotifier<List<FamilyMember>>;
String _$medicinesNotifierHash() => r'fb6a8e4d5b38e7284accb7e8799fbaca91589600';

/// See also [MedicinesNotifier].
@ProviderFor(MedicinesNotifier)
final medicinesNotifierProvider = AutoDisposeAsyncNotifierProvider<
    MedicinesNotifier, List<Medicine>>.internal(
  MedicinesNotifier.new,
  name: r'medicinesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicinesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MedicinesNotifier = AutoDisposeAsyncNotifier<List<Medicine>>;
String _$searchQueryNotifierHash() =>
    r'20edc3c31dd8fbfd83621f3ee327273abf8957ac';

/// See also [SearchQueryNotifier].
@ProviderFor(SearchQueryNotifier)
final searchQueryNotifierProvider =
    AutoDisposeNotifierProvider<SearchQueryNotifier, String>.internal(
  SearchQueryNotifier.new,
  name: r'searchQueryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchQueryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQueryNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
