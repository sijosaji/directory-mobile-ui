import 'package:flutter/material.dart';
import 'dart:math';

class UnitDetails extends StatefulWidget {
  final String? selectedUnitName;

  const UnitDetails({Key? key, this.selectedUnitName}) : super(key: key);

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  final List<Map<String, String>> units = [
    {"name": "St. Mary's", "image": "assets/mary.jpeg"},
    {"name": "St. George", "image": "assets/george.jpeg"},
    {"name": "Infant Jesus", "image": "assets/infant_jesus.jpg"},
    {"name": "St. Thomas", "image": "assets/thomas.jpeg"},
    {"name": "Holy Family", "image": "assets/holy_family.jpeg"},
    {"name": "St. Sebastian", "image": "assets/sebastian.jpeg"},
  ];

  late Map<String, String> selectedUnit;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    final matchingUnit = units.firstWhere(
      (unit) => unit["name"] == widget.selectedUnitName,
      orElse: () => units.first,
    );
    selectedUnit = Map<String, String>.from(matchingUnit);
  }

  Map<String, String> generateRandomDetails() {
    return {
      "No. of families": "${random.nextInt(50) + 10}",
      "President": "John Doe ${random.nextInt(100)}",
      "Vice President": "Jane Smith ${random.nextInt(100)}",
      "Secretary": "Paul Johnson ${random.nextInt(100)}",
      "Treasurer": "Emily Davis ${random.nextInt(100)}",
    };
  }

  @override
  Widget build(BuildContext context) {
    final unitDetails = generateRandomDetails();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button and unit selector
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      color: Colors.grey[700],
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: units.map((unit) {
                          bool isSelected = (unit["name"] == selectedUnit["name"]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedUnit = Map<String, String>.from(unit);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF4B6CB7) : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: !isSelected ? Border.all(color: Colors.grey[300]!) : null,
                                ),
                                child: Text(
                                  unit["name"]!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content with image and details
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unit image and name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              selectedUnit["image"]!,
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              padding: const EdgeInsets.symmetric(vertical: 14.0),
                              child: Center(
                                child: Text(
                                  selectedUnit["name"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Unit Details Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Unit Details",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              children: unitDetails.entries.map((entry) {
                                return Column(
                                  children: [
                                    buildDetailRow(entry.key, entry.value),
                                    const Divider(height: 24),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
