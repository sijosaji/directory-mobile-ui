import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/UserMetadataProvider.dart';
import 'BottomNavBar.dart';
import 'FamilyDetailsCard.dart';
import 'FamilyMembersCard.dart';
import 'HeaderSection.dart';
import 'AnniversaryCard.dart';
import '../enums/Unit.dart'; // Assume UnitMapper contains unit mapping logic


class FamilyProfile extends StatefulWidget {
  final String? familyId;

  const FamilyProfile({super.key, this.familyId});

  @override
  _FamilyProfileState createState() => _FamilyProfileState();
}

class _FamilyProfileState extends State<FamilyProfile> {
  late Future<Map<String, dynamic>> _familyDetailsFuture;
  late int _currentIndex = 2; // Variable to hold the dynamic current index

  @override
  void initState() {
    super.initState();
    // Set currentIndex based on the presence of a familyId
    _currentIndex = widget.familyId == null ? 2 : 1;
    _familyDetailsFuture = _fetchFamilyDetails(widget.familyId);
  }

  Future<Map<String, dynamic>> _fetchFamilyDetails(String? familyId) async {
    try {
      final userMetadata =
          Provider.of<UserMetadataProvider>(context, listen: false)
              .userMetadata;
      final effectiveFamilyId = familyId ?? userMetadata['familyId'];

      if (effectiveFamilyId == null) {
        throw Exception('Family ID not found.');
      }

      final response = await http.get(
        Uri.parse(
            'https://prior-kali-sijo-adcd7b71.koyeb.app/api/families/$effectiveFamilyId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch family details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching family details: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _familyDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Unable to load family details. Please try again later.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            final familyDetails = snapshot.data!;
            final familyMembers = List<Map<String, dynamic>>.from(
              familyDetails['familyMembers'] ?? [],
            );

            final couples = List<Map<String, dynamic>>.from(
              familyDetails['couples'] ?? [],
            );

            // Find the family head
            final familyHead = familyMembers.firstWhere(
              (member) => member['isFamilyHead'] == true,
              orElse: () => {'name': 'Family Head Not Found'},
            )['name'];

            // Filter and map members excluding family head
            final nonHeadMembers = familyMembers
                .map((member) => {
                      'name': member['name'] ?? 'N/A',
                      'emailId': member['emailId'] ?? 'N/A',
                      'phoneNumber': member['phoneNumber'] ?? 'N/A',
                      'bloodGroup': member['bloodGroup'] ?? 'N/A',
                      'dob': member['dob'] ?? 'N/A',
                    })
                .toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderSection(
                    name: familyHead ?? 'Family Name',
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Family Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FamilyDetailsCard(
                    details: [
                      {
                        'title': 'Unit',
                        'value': mapUnit(familyDetails['unit']) ?? 'N/A'
                      },
                      {
                        'title': 'Address',
                        'value': familyDetails['address'] ?? 'N/A'
                      },
                      {
                        'title': 'House Name',
                        'value': familyDetails['houseName'] ?? 'N/A'
                      },
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Family Members',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FamilyMembersCard(
                    members: nonHeadMembers,
                  ),
                  if (familyDetails.containsKey('couples') &&
                      (familyDetails['couples'] as List).isNotEmpty) ...[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Anniversary Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnniversaryCard(
                      couples: List<Map<String, dynamic>>.from(
                          familyDetails['couples']),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex, // Use dynamic currentIndex
        parentContext: context,
      ),
    );
  }
}
