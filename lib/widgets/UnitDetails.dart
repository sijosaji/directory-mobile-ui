import 'package:flutter/material.dart';

class UnitDetails extends StatefulWidget {
  const UnitDetails({Key? key}) : super(key: key);

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  // List of units (for horizontal scrolling)
  final List<String> units = [
    "St. Mary's",
    "St. George",
    "Infant Jesus",
    "St. Thomas",
    "St. Antony",
    "Little Flower",
    "St. Joseph",
    "Holy Family",
    "St. Sebastian",
  ];

  String selectedUnit = "St. Mary's";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar with back button and scrollable units
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Back button - gray with more padding
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      color: Colors.grey[700],
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // Horizontal scrolling unit tabs
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: units.map((unit) {
                          bool isSelected = (unit == selectedUnit);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedUnit = unit;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF4B6CB7)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: !isSelected
                                      ? Border.all(color: Colors.grey[300]!)
                                      : null,
                                ),
                                child: Text(
                                  unit,
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.white : Colors.black,
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

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // St. Mary's image with text overlay
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Image with rounded corners on all sides - larger height
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/st_marys.jpg',
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          // Text positioned at the bottom of the image
                          Positioned(
                            bottom: 0, // Positioned at the very bottom
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "St. Mary's",
                                  style: TextStyle(
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

                    // Unit Details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Unit Details header
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

                          // Unit Details card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              children: [
                                buildDetailRow("No. of families", "20"),
                                const Divider(height: 24),
                                buildDetailRow("President", "Johnson Joseph"),
                                const Divider(height: 24),
                                buildDetailRow("Vice President", "Jolly Mathew"),
                                const Divider(height: 24),
                                buildDetailRow("Secretary", "K.M. Mathew"),
                                const Divider(height: 24),
                                buildDetailRow("Treasurer", "James P.J."),
                              ],
                            ),
                          ),

                          // Unit Members section with arrow close to text
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Unit Members",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom spacer
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

  // Helper widget to build a single row of label + value with left alignment
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed-width box for label
          SizedBox(
            width: 130, // Adjust this width as you like
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, // Keep label bold
              ),
            ),
          ),
          // Some space between label and value
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
