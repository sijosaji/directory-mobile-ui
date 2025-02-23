import 'package:directory/widgets/BannerTile.dart';
import 'package:directory/widgets/BottomNavBar.dart';
import 'package:directory/widgets/ChurchUnitTile.dart';
import 'package:directory/widgets/ScrollingDotsIndicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Row(
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
        const CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpeg'),
        ),
      ],
    );
  }

  Widget _buildBanners() {
    return Column(
      children: [
        BannerTile(title: 'All About Us', imagePath: 'assets/church.jpeg'),
        const SizedBox(height: 10),
        BannerTile(title: 'Parish Directory', imagePath: 'assets/bible.jpg'),
      ],
    );
  }

  Widget _buildChurchUnits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Church Units', style: _sectionTitleStyle()),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              ChurchUnitTile(title: 'St. Marys', imagePath: 'assets/mary.jpeg'),
              ChurchUnitTile(title: 'St. George', imagePath: 'assets/george.jpeg'),
              ChurchUnitTile(title: 'St. Sebastian', imagePath: 'assets/sebastian.jpeg'),
              ChurchUnitTile(title: 'St. Thomas', imagePath: 'assets/thomas.jpeg'),
              ChurchUnitTile(title: 'Holy Family', imagePath: 'assets/holy_family.jpeg'),
              ChurchUnitTile(title: 'Infant Jesus', imagePath: 'assets/infant_jesus.jpg'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ScrollingDotsIndicator(
          controller: _scrollController,
          itemCount: 6,
        ),
      ],
    );
  }

  TextStyle _sectionTitleStyle() {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        parentContext: context,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildBanners(),
                const SizedBox(height: 20),
                _buildChurchUnits(),
                const SizedBox(height: 20),
                Text('Committees', style: _sectionTitleStyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}