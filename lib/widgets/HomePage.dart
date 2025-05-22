import 'package:directory/providers/UserMetadataProvider.dart';
import 'package:directory/widgets/BannerTile.dart';
import 'package:directory/widgets/BottomNavBar.dart';
import 'package:directory/widgets/ChurchCommittees.dart';
import 'package:directory/widgets/ChurchUnitTile.dart';
import 'package:directory/widgets/DirectoryScreen.dart';
import 'package:directory/widgets/ScrollingDotsIndicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  Provider.of<UserMetadataProvider>(context, listen: false).logout();  
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (Route<dynamic> route) => false, // Remove all previous routes
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
          height: 150,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                _scrollController.position.context.setIgnorePointer(true);
              } else if (notification is ScrollEndNotification) {
                _scrollController.position.context.setIgnorePointer(false);
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              clipBehavior: Clip.none,
              itemCount: 9,
              itemBuilder: (context, index) {
                final units = [
                  {'title': 'St. Marys', 'image': 'assets/mother_mary.png'},
                  {'title': 'St. George', 'image': 'assets/st_george_small.png'},
                  {'title': 'St. Sebastian', 'image': 'assets/st_sebastian_smalll.png'},
                  {'title': 'St. Thomas', 'image': 'assets/st_thomas_small.png'},
                  {'title': 'Holy Family', 'image': 'assets/holy_family_small.png'},
                  {'title': 'Infant Jesus', 'image': 'assets/infant_jesus_small.png'},
                  {'title': 'Little Flower', 'image': 'assets/little_flower_small.png'},
                  {'title': 'St. Joseph', 'image': 'assets/st_joseph_small.png'},
                  {'title': 'St. Antony', 'image': 'assets/st_antony_small.png'},
                ];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChurchUnitTile(
                    title: units[index]['title']!,
                    imagePath: units[index]['image']!,
                  ),
                );
              },
            ),
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                _committeeScrollController.position.context.setIgnorePointer(true);
              } else if (notification is ScrollEndNotification) {
                _committeeScrollController.position.context.setIgnorePointer(false);
              }
              return true;
            },
            child: ListView.builder(
              controller: _committeeScrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              clipBehavior: Clip.none,
              itemCount: 4,
              itemBuilder: (context, index) {
                final committees = [
                  {'title': 'Pithruvedi', 'image': 'assets/pithruvedi_logo.jpeg'},
                  {'title': 'Mathruvedi', 'image': 'assets/mathruvedi_logo.jpeg'},
                  {'title': 'Nurses Guild', 'image': 'assets/nurses_guild_logo.jpeg'},
                  {'title': 'DSYM', 'image': 'assets/dsym_logo.jpeg'},
                ];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChurchCommittees(
                    title: committees[index]['title']!,
                    imagePath: committees[index]['image']!,
                  ),
                );
              },
            ),
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
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildBanners(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildChurchUnits(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildCommittees(),
              ),
            ),
            // Add some bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }
}
