import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/search_service.dart';
import '../models/medicine.dart';
import '../models/family_member.dart';
import 'app_provider.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  SearchService build() {
    return SearchService();
  }
}

@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
}

@riverpod
class SearchFilterNotifier extends _$SearchFilterNotifier {
  @override
  SearchFilter build() => SearchFilter.all;

  void updateFilter(SearchFilter filter) {
    state = filter;
  }
}

@riverpod
class SelectedFamilyMemberNotifier extends _$SelectedFamilyMemberNotifier {
  @override
  String? build() => null;

  void selectFamilyMember(String? memberId) {
    state = memberId;
  }
}

@riverpod
Future<List<SearchResult>> searchResults(SearchResultsRef ref) async {
  final query = ref.watch(searchQueryNotifierProvider);
  final filter = ref.watch(searchFilterNotifierProvider);
  final selectedMemberId = ref.watch(selectedFamilyMemberNotifierProvider);
  final medicines = await ref.watch(medicinesNotifierProvider.future);
  final familyMembers = await ref.watch(familyMembersNotifierProvider.future);
  
  return ref.watch(searchNotifierProvider).searchMedicines(
    query: query,
    medicines: medicines,
    familyMembers: familyMembers,
    filter: filter,
    selectedFamilyMemberId: selectedMemberId,
  );
}

@riverpod
Future<List<FamilyMember>> searchFamilyMembers(
  SearchFamilyMembersRef ref,
  String query,
) async {
  final familyMembers = await ref.watch(familyMembersNotifierProvider.future);
  return ref.watch(searchNotifierProvider).searchFamilyMembers(
    query: query,
    familyMembers: familyMembers,
  );
} 