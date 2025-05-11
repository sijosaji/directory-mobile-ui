import 'package:directory/widgets/BannerTile.dart';
import 'package:directory/widgets/BottomNavBar.dart';
import 'package:directory/widgets/ChurchCommittees.dart';
import 'package:directory/widgets/ChurchUnitTile.dart';
import 'package:directory/widgets/DirectoryScreen.dart';
import 'package:directory/widgets/ScrollingDotsIndicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _committeeScrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _committeeScrollController.dispose();
    super.dispose();
  }

  void _handleSignOut() {
  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
}

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                  radius: 35,
                ),
                const SizedBox(height: 12),
                Text(
                  'Sign out',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleSignOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        GestureDetector(
          onTap: () {
            _showProfileOptions(context);
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpeg'),
            radius: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildBanners() {
    return Column(
      children: [
        BannerTile(title: 'All About Us', imagePath: 'assets/church.jpeg'),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DirectoryScreen()),
            );
          },
          child: BannerTile(title: 'Parish Directory', imagePath: 'assets/bible.jpg'),
        ),
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

  Widget _buildCommittees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Committees', style: _sectionTitleStyle()),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView(
            controller: _committeeScrollController,
            scrollDirection: Axis.horizontal,
            children: [
              ChurchCommittees(title: 'Pithruvedi', imagePath: 'assets/pithruvedi_logo.jpeg'),
              ChurchCommittees(title: 'Mathruvedi', imagePath: 'assets/mathruvedi_logo.jpeg'),
              ChurchCommittees(title: 'Nurses Guild', imagePath: 'assets/nurses_guild_logo.jpeg'),
              ChurchCommittees(title: 'DSYM', imagePath: 'assets/dsym_logo.jpeg'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ScrollingDotsIndicator(
          controller: _committeeScrollController,
          itemCount: 4,
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
                _buildCommittees(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
