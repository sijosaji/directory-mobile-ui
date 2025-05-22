import 'package:flutter/material.dart';

class CircleBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CircleBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 18),
        color: Colors.white,
        onPressed: onPressed ?? () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}

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
          child: CircleBackButton(),
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
