import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/family_member.dart';
import 'family_member_details.dart';

class FamilyMemberList extends StatelessWidget {
  const FamilyMemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListView.builder(
          itemCount: appState.familyMembers.length,
          itemBuilder: (context, index) {
            final familyMember = appState.familyMembers[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: familyMember.photoPath != null
                    ? AssetImage(familyMember.photoPath!)
                    : null,
                child: familyMember.photoPath == null
                    ? Text(familyMember.name[0])
                    : null,
              ),
              title: Text(familyMember.name),
              subtitle: Text('Age: ${familyMember.age ?? 'N/A'}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FamilyMemberDetails(familyMember: familyMember),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

