import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String name;

  const HeaderSection({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Image.network(
          'https://crabapplephotography.com/wp-content/uploads/2024/02/outdoor-family-portraits_0018.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        // Back button on top left
        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            color: Colors.grey[700],
            onPressed: () => Navigator.pop(context), // Handle back button press
          ),
        ),
        // Family name text at the bottom
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
      ],
    );
  }
}
