import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerTile extends StatelessWidget {
  final String title;
  final String imagePath;

  BannerTile({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(imagePath, width: double.infinity, height: 120, fit: BoxFit.cover),
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.black.withOpacity(0.3),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}