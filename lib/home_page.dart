import 'package:flutter/material.dart';
import 'family_member.dart';
import 'family_member_list.dart';
import 'add_family_member_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FamilyMember> _familyMembers = [];

  void _addFamilyMember(FamilyMember familyMember) {
    setState(() {
      _familyMembers.add(familyMember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediAlert'),
      ),
      body: FamilyMemberList(familyMembers: _familyMembers),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<FamilyMember>(
            context: context,
            builder: (context) => const AddFamilyMemberDialog(),
          );
          if (result != null) {
            _addFamilyMember(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

