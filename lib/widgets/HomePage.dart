
import 'package:directory/widgets/BannerTile.dart';
import 'package:directory/widgets/ChurchUnitTile.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Directory'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'St. Jude Parish',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sahibabad',
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BannerTile(title: 'All About Us', imagePath: 'assets/church.jpg'),
                SizedBox(height: 10),
                BannerTile(title: 'Parish Directory', imagePath: 'assets/bible.jpg'),
                SizedBox(height: 20),
                Text('Church Units', style: sectionTitleStyle()),
                SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ChurchUnitTile(title: 'St. Marys', imagePath: 'assets/mary.jpeg'),
                      ChurchUnitTile(title: 'St. George', imagePath: 'assets/george.jpeg'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('Committees', style: sectionTitleStyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  TextStyle sectionTitleStyle() {
  return GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
}