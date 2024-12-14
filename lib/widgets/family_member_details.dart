import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import 'add_medicine_dialog.dart';

class FamilyMemberDetails extends StatelessWidget {
  final FamilyMember familyMember;

  const FamilyMemberDetails({Key? key, required this.familyMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(familyMember.name),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          final medicines = appState.getMedicinesForFamilyMember(familyMember.key as String);
          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return ListTile(
                title: Text(medicine.name),
                subtitle: Text('${medicine.dosage} - ${medicine.type}'),
                trailing: Text('Quantity: ${medicine.quantity}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddMedicineDialog(familyMemberId: familyMember.key as String),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

