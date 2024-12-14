import 'package:flutter/material.dart';
import 'family_member.dart';
import 'medicine_list.dart';

class FamilyMemberList extends StatelessWidget {
  final List<FamilyMember> familyMembers;

  const FamilyMemberList({Key? key, required this.familyMembers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: familyMembers.length,
      itemBuilder: (context, index) {
        final familyMember = familyMembers[index];
        return ListTile(
          title: Text(familyMember.name),
          subtitle: Text('${familyMember.medicines.length} medicines'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicineList(familyMember: familyMember),
              ),
            );
          },
        );
      },
    );
  }
}

