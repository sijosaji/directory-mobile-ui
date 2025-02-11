import 'package:flutter/material.dart';
import '../enums/BloodGroup.dart';
import '../helper/DobHelper.dart';


import 'MemberRow.dart';

class FamilyMembersCard extends StatelessWidget {
  final List<Map<String, dynamic>> members;

  const FamilyMembersCard({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.all(16),
      child: Column(
        children: members
            .map((member) => Column(
                  children: [
                    MemberRow(
                      name: member['name']!,
                      phone: member['phoneNumber']!,
                      email: member['emailId']!,
                      bloodGroup: mapBloodGroup(member['bloodGroup'])!,
                      dob: dobMapper(member['dob'])!,
                    ),
                    if (member != members.last) const Divider(),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
