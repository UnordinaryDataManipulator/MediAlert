import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../providers/app_state.dart';
import 'package:uuid/uuid.dart';

class AddMedicineDialog extends StatefulWidget {
  final String familyMemberId;
  final Medicine? medicine;

  const AddMedicineDialog({
    Key? key,
    required this.familyMemberId,
    this.medicine,
  }) : super(key: key);

  @override
  _AddMedicineDialogState createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _quantityController = TextEditingController();
  final _thresholdController = TextEditingController();
  final List<String> _scheduledTimes = [];

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) {
      _nameController.text = widget.medicine!.name;
      _instructionsController.text = widget.medicine!.dosageInstructions;
      _quantityController.text = widget.medicine!.quantity.toString();
      _thresholdController.text = widget.medicine!.alertThreshold.toString();
      _scheduledTimes.addAll(widget.medicine!.scheduledTimes);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _instructionsController.dispose();
    _quantityController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  Future<void> _addTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    if (time != null) {
      setState(() {
        _scheduledTimes.add('${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.medicine == null ? 'Add Medicine' : 'Edit Medicine'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medicine Name',
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Dosage Instructions',
                  hintText: 'E.g., 1 tablet twice daily with meals',
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _thresholdController,
                      decoration: const InputDecoration(
                        labelText: 'Alert When Below',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Scheduled Times:'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTime,
                  ),
                ],
              ),
              if (_scheduledTimes.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: _scheduledTimes.map((time) => Chip(
                    label: Text(time),
                    onDeleted: () => setState(() => _scheduledTimes.remove(time)),
                  )).toList(),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && _scheduledTimes.isNotEmpty) {
              final medicine = Medicine(
                id: widget.medicine?.id ?? const Uuid().v4(),
                name: _nameController.text,
                dosageInstructions: _instructionsController.text,
                quantity: int.parse(_quantityController.text),
                alertThreshold: int.parse(_thresholdController.text),
                scheduledTimes: List.from(_scheduledTimes),
                familyMemberId: widget.familyMemberId,
              );

              final appState = context.read<AppState>();
              if (widget.medicine == null) {
                appState.addMedicine(medicine);
              } else {
                appState.updateMedicine(medicine);
              }

              Navigator.of(context).pop();
            } else if (_scheduledTimes.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add at least one scheduled time')),
              );
            }
          },
          child: Text(widget.medicine == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

