import 'package:flutter/material.dart';

import 'DetailRow.dart';

class FamilyDetailsCard extends StatelessWidget {
  final List<Map<String, String>> details;

  const FamilyDetailsCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: details
              .map((detail) => Column(
                    children: [
                      DetailRow(title: detail['title']!, value: detail['value']!),
                      if (detail != details.last) const Divider(),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
