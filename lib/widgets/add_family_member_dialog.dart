import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import 'package:uuid/uuid.dart';

class AddFamilyMemberDialog extends ConsumerStatefulWidget {
  final FamilyMember? member;

  const AddFamilyMemberDialog({
    Key? key,
    this.member,
  }) : super(key: key);

  @override
  ConsumerState<AddFamilyMemberDialog> createState() => _AddFamilyMemberDialogState();
}

class _AddFamilyMemberDialogState extends ConsumerState<AddFamilyMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _notesController;
  late DateTime _dateOfBirth;
  bool _isCaregiver = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member?.name);
    _relationshipController = TextEditingController(text: widget.member?.relationship);
    _notesController = TextEditingController(text: widget.member?.notes);
    _dateOfBirth = widget.member?.dateOfBirth ?? DateTime.now();
    _isCaregiver = widget.member?.isCaregiver ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.member == null ? 'Add Family Member' : 'Edit Family Member'),
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
                  hintText: 'Enter name',
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
                controller: _relationshipController,
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                  hintText: 'E.g., Father, Mother, Son',
                ),
              ),
              const SizedBox(height: AppTheme.smallPadding),
              ListTile(
                title: const Text('Date of Birth'),
                subtitle: Text(
                  '${_dateOfBirth.year}-${_dateOfBirth.month.toString().padLeft(2, '0')}-${_dateOfBirth.day.toString().padLeft(2, '0')}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: AppTheme.smallPadding),
              SwitchListTile(
                title: const Text('Is Caregiver'),
                value: _isCaregiver,
                onChanged: (bool value) {
                  setState(() {
                    _isCaregiver = value;
                  });
                },
              ),
              const SizedBox(height: AppTheme.smallPadding),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Add any additional notes',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value != null && value.length > ValidationConstants.maxNotesLength) {
                    return 'Notes are too long';
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
              final member = FamilyMember(
                id: widget.member?.id ?? const Uuid().v4(),
                name: _nameController.text,
                dateOfBirth: _dateOfBirth,
                relationship: _relationshipController.text.isEmpty
                    ? null
                    : _relationshipController.text,
                notes: _notesController.text.isEmpty ? null : _notesController.text,
                isCaregiver: _isCaregiver,
                medicineIds: widget.member?.medicineIds ?? [],
                preferences: widget.member?.preferences ?? {},
              );

              if (widget.member == null) {
                await ref
                    .read(familyMembersNotifierProvider.notifier)
                    .addFamilyMember(member);
              } else {
                await ref
                    .read(familyMembersNotifierProvider.notifier)
                    .updateFamilyMember(member);
              }

              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(widget.member == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

