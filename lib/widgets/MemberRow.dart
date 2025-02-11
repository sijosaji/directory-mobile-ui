import 'package:flutter/material.dart';

class MemberRow extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String bloodGroup;
  final String dob;


  const MemberRow({super.key, required this.name, required this.phone, required this.email, required this.bloodGroup, required this.dob});

  @override
  _MemberRowState createState() => _MemberRowState();
}

class _MemberRowState extends State<MemberRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.name),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 16,
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(widget.phone),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(widget.email),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bloodtype, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(widget.bloodGroup),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.cake, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(widget.dob),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
