import 'package:flutter/material.dart';
import 'family_member.dart';
import 'medicine.dart';
import 'add_medicine_dialog.dart';

class MedicineList extends StatefulWidget {
  final FamilyMember familyMember;

  const MedicineList({Key? key, required this.familyMember}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  void _addMedicine(Medicine medicine) {
    setState(() {
      widget.familyMember.addMedicine(medicine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.familyMember.name}\'s Medicines'),
      ),
      body: ListView.builder(
        itemCount: widget.familyMember.medicines.length,
        itemBuilder: (context, index) {
          final medicine = widget.familyMember.medicines[index];
          return ListTile(
            title: Text(medicine.name),
            subtitle: Text('${medicine.dosage} - ${medicine.frequency}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Medicine>(
            context: context,
            builder: (context) => const AddMedicineDialog(),
          );
          if (result != null) {
            _addMedicine(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

