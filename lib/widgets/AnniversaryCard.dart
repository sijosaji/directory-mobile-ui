import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for formatting dates

class AnniversaryCard extends StatelessWidget {
  final List<Map<String, dynamic>> couples;

  const AnniversaryCard({super.key, required this.couples});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity, // Set the card width to be as wide as possible within the screen
        child: Card(
          color: Colors.grey[200],
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16), // Padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: couples.map((couple) {
                final spouse1 = couple['spouce1'] ?? 'N/A';
                final spouse2 = couple['spouce2'] ?? 'N/A';
                final anniversaryDate = couple['anniversaryDate'] ?? 'N/A';

                // Format the date to show Month as word and Day (e.g., Jan 05)
                String formattedDate = 'N/A';
                if (anniversaryDate != 'N/A') {
                  try {
                    DateTime date = DateTime.parse(anniversaryDate);
                    formattedDate = DateFormat('MMM dd').format(date); // Format to MMM dd
                  } catch (e) {
                    print('Error formatting date: $e');
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$spouse1 & $spouse2 : $formattedDate', // Showing date inline
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
