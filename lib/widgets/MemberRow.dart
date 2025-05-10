import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberRow extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? email;
  final String? bloodGroup;
  final String? dob;

  const MemberRow({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.bloodGroup,
    required this.dob,
  });

  @override
  _MemberRowState createState() => _MemberRowState();
}

class _MemberRowState extends State<MemberRow> {
  bool isExpanded = false;

  bool _isNotEmpty(String? value) => value != null && value.trim().isNotEmpty;

  void _copyToClipboard(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied to clipboard')),
    );
  }

  Widget buildRow({
    required IconData icon,
    required String label,
    required String value,
    bool addTopPadding = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: addTopPadding ? 8 : 0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
          IconButton(
            icon: const Icon(Icons.content_copy, size: 16),
            tooltip: 'Copy',
            onPressed: () => _copyToClipboard(label, value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];
    if (_isNotEmpty(widget.phone)) {
      rows.add(buildRow(icon: Icons.phone, label: 'Phone Number', value: widget.phone!));
    }
    if (_isNotEmpty(widget.email)) {
      rows.add(buildRow(
          icon: Icons.email,
          label: 'EmailId',
          value: widget.email!,
          addTopPadding: rows.isNotEmpty));
    }
    if (_isNotEmpty(widget.bloodGroup)) {
      rows.add(buildRow(
          icon: Icons.bloodtype,
          label: 'Blood Group',
          value: widget.bloodGroup!,
          addTopPadding: rows.isNotEmpty));
    }
    if (_isNotEmpty(widget.dob)) {
      rows.add(buildRow(
          icon: Icons.cake, label: 'Date Of Birth', value: widget.dob!, addTopPadding: rows.isNotEmpty));
    }

    return Column(
      children: [
        ListTile(
          title: Text(widget.name ?? ''),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows,
            ),
          ),
      ],
    );
  }
}
