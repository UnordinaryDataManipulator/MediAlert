import 'package:flutter/material.dart';
import 'medicine.dart';

class AddMedicineDialog extends StatefulWidget {
  const AddMedicineDialog({Key? key}) : super(key: key);

  @override
  _AddMedicineDialogState createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Medicine'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a medicine name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dosageController,
              decoration: const InputDecoration(labelText: 'Dosage'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the dosage';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _frequencyController,
              decoration: const InputDecoration(labelText: 'Frequency'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the frequency';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                Medicine(
                  name: _nameController.text,
                  dosage: _dosageController.text,
                  frequency: _frequencyController.text,
                ),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }
}

