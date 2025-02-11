import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;

  const HeaderSection({super.key, required this.name, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://crabapplephotography.com/wp-content/uploads/2024/02/outdoor-family-portraits_0018.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
