import '../models/medicine.dart';
import '../models/family_member.dart';

enum SearchFilter {
  all,
  lowStock,
  expiringSoon,
  byFamilyMember,
}

class SearchResult {
  final Medicine medicine;
  final FamilyMember familyMember;

  SearchResult({
    required this.medicine,
    required this.familyMember,
  });
}

class SearchService {
  List<SearchResult> searchMedicines({
    required String query,
    required List<Medicine> medicines,
    required List<FamilyMember> familyMembers,
    SearchFilter filter = SearchFilter.all,
    String? selectedFamilyMemberId,
  }) {
    if (query.isEmpty && filter == SearchFilter.all) {
      return _createSearchResults(medicines, familyMembers);
    }

    final lowercaseQuery = query.toLowerCase();
    var filteredMedicines = medicines.where((medicine) {
      final matchesQuery = query.isEmpty ||
          medicine.name.toLowerCase().contains(lowercaseQuery) ||
          medicine.dosage.toLowerCase().contains(lowercaseQuery) ||
          medicine.frequency.toLowerCase().contains(lowercaseQuery) ||
          (medicine.instructions?.toLowerCase().contains(lowercaseQuery) ?? false);

      if (!matchesQuery) return false;

      switch (filter) {
        case SearchFilter.all:
          return true;
        case SearchFilter.lowStock:
          return medicine.currentQuantity <= medicine.minimumQuantity;
        case SearchFilter.expiringSoon:
          if (medicine.expiryDate == null) return false;
          final daysUntilExpiry = medicine.expiryDate!
              .difference(DateTime.now())
              .inDays;
          return daysUntilExpiry <= 30 && daysUntilExpiry >= 0;
        case SearchFilter.byFamilyMember:
          return selectedFamilyMemberId != null &&
              medicine.metadata['familyMemberId'] == selectedFamilyMemberId;
      }
    }).toList();

    return _createSearchResults(filteredMedicines, familyMembers);
  }

  List<SearchResult> _createSearchResults(
    List<Medicine> medicines,
    List<FamilyMember> familyMembers,
  ) {
    return medicines.map((medicine) {
      final familyMember = familyMembers.firstWhere(
        (member) => member.id == medicine.metadata['familyMemberId'],
        orElse: () => throw Exception('Family member not found for medicine'),
      );
      return SearchResult(
        medicine: medicine,
        familyMember: familyMember,
      );
    }).toList();
  }

  List<FamilyMember> searchFamilyMembers({
    required String query,
    required List<FamilyMember> familyMembers,
  }) {
    if (query.isEmpty) return familyMembers;

    final lowercaseQuery = query.toLowerCase();
    return familyMembers.where((member) {
      return member.name.toLowerCase().contains(lowercaseQuery) ||
          (member.relationship?.toLowerCase().contains(lowercaseQuery) ?? false) ||
          (member.notes?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }
} 