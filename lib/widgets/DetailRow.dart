import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
