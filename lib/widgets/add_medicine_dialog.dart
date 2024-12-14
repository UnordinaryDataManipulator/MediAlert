import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import '../services/reminder_service.dart';
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
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _instructionsController = TextEditingController();
  DateTime? _expiryDate;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) {
      _nameController.text = widget.medicine!.name;
      _dosageController.text = widget.medicine!.dosage;
      _frequencyController.text = widget.medicine!.frequency;
      _quantityController.text = widget.medicine!.currentQuantity.toString();
      _minQuantityController.text = widget.medicine!.minimumQuantity.toString();
      _instructionsController.text = widget.medicine!.instructions ?? '';
      _expiryDate = widget.medicine!.expiryDate;
      _imageUrl = widget.medicine!.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    _quantityController.dispose();
    _minQuantityController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)), // 10 years
    );
    if (picked != null) {
      setState(() {
        _expiryDate = picked;
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
                  labelText: 'Name',
                  hintText: 'Enter medicine name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ErrorMessages.requiredField;
                  }
                  if (value.length > ValidationConstants.maxNameLength) {
                    return 'Name is too long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.smallPadding),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage',
                  hintText: 'E.g., 500mg, 2 tablets',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ErrorMessages.requiredField;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.smallPadding),
              TextFormField(
                controller: _frequencyController,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ErrorMessages.requiredField;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.smallPadding),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Current Stock',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ErrorMessages.requiredField;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          _currentQuantity = number;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: AppTheme.defaultPadding),
                  Expanded(
                    child: TextFormField(
                      controller: _minQuantityController,
                      decoration: const InputDecoration(
                        labelText: 'Minimum Stock',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ErrorMessages.requiredField;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          _minimumQuantity = number;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.smallPadding),
              ListTile(
                title: const Text('Expiry Date'),
                subtitle: Text(
                  _expiryDate == null
                      ? 'Not set'
                      : '${_expiryDate!.year}-${_expiryDate!.month.toString().padLeft(2, '0')}-${_expiryDate!.day.toString().padLeft(2, '0')}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_expiryDate != null)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _expiryDate = null;
                          });
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectExpiryDate(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.smallPadding),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                  hintText: 'Add any special instructions',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value != null && value.length > ValidationConstants.maxNotesLength) {
                    return 'Instructions are too long';
                  }
                  return null;
                },
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final medicine = Medicine(
                id: widget.medicine?.id ?? const Uuid().v4(),
                name: _nameController.text,
                dosage: _dosageController.text,
                frequency: _frequencyController.text,
                expiryDate: _expiryDate,
                currentQuantity: _currentQuantity,
                minimumQuantity: _minimumQuantity,
                instructions: _instructionsController.text.isEmpty
                    ? null
                    : _instructionsController.text,
                barcode: widget.medicine?.barcode,
                imageUrl: widget.medicine?.imageUrl,
                scheduledTimes: widget.medicine?.scheduledTimes ?? [],
                metadata: {
                  ...widget.medicine?.metadata ?? {},
                  'familyMemberId': widget.familyMemberId,
                },
              );

              if (widget.medicine == null) {
                await ref
                    .read(medicinesNotifierProvider.notifier)
                    .addMedicine(medicine);
              } else {
                await ref
                    .read(medicinesNotifierProvider.notifier)
                    .updateMedicine(medicine);
              }

              // Schedule reminders
              final reminderService = ReminderService();
              await reminderService.scheduleMedicineReminder(medicine);

              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(widget.medicine == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

