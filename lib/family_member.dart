import 'medicine.dart';

class FamilyMember {
  final String name;
  final List<Medicine> medicines;

  FamilyMember({required this.name, List<Medicine>? medicines})
      : medicines = medicines ?? [];

  void addMedicine(Medicine medicine) {
    medicines.add(medicine);
  }
}

