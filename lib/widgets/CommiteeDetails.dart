import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HeaderSection.dart';

class Commiteedetails extends StatefulWidget {
  final String? selectedUnitName;

  const Commiteedetails({Key? key, this.selectedUnitName}) : super(key: key);

  @override
  _CommiteedetailsState createState() => _CommiteedetailsState();
}

class _CommiteedetailsState extends State<Commiteedetails> {
  final List<Map<String, String>> committees = [
    {"name": "Mathruvedi", "image": "assets/mathruvedi_logo.jpeg"},
    {"name": "Pithruvedi", "image": "assets/pithruvedi_logo.jpeg"},
    {"name": "DSYM", "image": "assets/dsym_logo.jpeg"},
    {"name": "Nurses Guild", "image": "assets/nurses_guild_logo.jpeg"},
  ];

  final Map<String, Map<String, String>> committeeMembers = {
    'Mathruvedi': {
      'President': 'Ancy Sabu',
      'Vice President': 'Jolly Thomas',
      'Secretary': 'Jolly Johnson',
      'Joint Secretary': 'Saly Joychan',
      'Treasurer': 'Tushara Jomon',
      'Joint Treasurer': 'Tintu Saji',
    },
    'Pithruvedi': {
      'President': 'George Varkey',
      'Vice President': 'Raju P Mathew',
      'Secretary': 'Joby Mathew',
      'Joint Secretary': 'Jomon Thomas',
      'Treasurer': 'Joshy Kurian',
      'Joint Treasurer': 'NA',
    },
    'DSYM': {
      'President': 'Sherin Sabu',
      'Vice President': 'Stephen Thomas',
      'Secretary': 'Carolin Xavier',
      'Joint Secretary': 'Edwin Jacob',
      'Treasurer': 'Melvin Manuel',
      'Joint Treasurer': 'NA',
    },
    'Nurses Guild': {
      'President': 'Mini James',
      'Vice President': 'Dinil P Joy',
      'Secretary': 'Dolly Joji',
      'Joint Secretary': 'Mary Shaji',
      'Treasurer': 'Hilda Ann Jose',
      'Joint Treasurer': 'NA',
    },
  };

  late String selectedCommittee;
  final ScrollController _committeeScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedCommittee = widget.selectedUnitName ?? committees.first['name']!;
  }

  @override
  void dispose() {
    _committeeScrollController.dispose();
    super.dispose();
  }

  void _changeCommitteeBySwipe(bool isLeft) {
    int currentIndex = committees.indexWhere((c) => c["name"] == selectedCommittee);
    int newIndex = currentIndex;
    
    if (isLeft && currentIndex < committees.length - 1) {
      newIndex = currentIndex + 1;
    } else if (!isLeft && currentIndex > 0) {
      newIndex = currentIndex - 1;
    }
    
    if (newIndex != currentIndex) {
      setState(() {
        selectedCommittee = committees[newIndex]["name"]!;
      });
      // Use Future.microtask to ensure smooth animation
      Future.microtask(() => _scrollToCommittee(newIndex));
    }
  }

  void _scrollToCommittee(int index) {
    // Calculate the center position of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 120.0; // Width of each committee item including padding
    final itemCenter = (index * itemWidth) + (itemWidth / 2);
    final screenCenter = screenWidth / 2;
    
    // Calculate the offset needed to center the selected item
    double offset = itemCenter - screenCenter;
    
    // Ensure we don't scroll beyond bounds
    offset = offset.clamp(0.0, _committeeScrollController.position.maxScrollExtent);
    
    _committeeScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500), // Increased duration for smoother animation
      curve: Curves.easeOutCubic, // Changed curve for smoother motion
    );
  }

  @override
  Widget build(BuildContext context) {
    final members = committeeMembers[selectedCommittee] ?? {};

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleBackButton(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _committeeScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: committees.map((committee) {
                          bool isSelected = (committee["name"] == selectedCommittee);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCommittee = committee["name"]!;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF4B6CB7) : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: !isSelected ? Border.all(color: Colors.grey[300]!) : null,
                                ),
                                child: Text(
                                  committee["name"]!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! < -300) {  // Swipe left threshold
                      _changeCommitteeBySwipe(true);
                    } else if (details.primaryVelocity! > 300) {  // Swipe right threshold
                      _changeCommitteeBySwipe(false);
                    }
                  }
                },
                behavior: HitTestBehavior.opaque,  // Add this to ensure gesture detection
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),  // Add this to prevent scroll interference
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                committees.firstWhere((c) => c['name'] == selectedCommittee)['image']!,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 32,
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                                child: Center(
                                  child: Text(
                                    selectedCommittee,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Committee Members',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.only(bottom: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Table(
                                columnWidths: {
                                  0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.4),
                                  1: FlexColumnWidth(),
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: _buildTableRows(members),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows(Map<String, String> members) {
    List<TableRow> rows = [];
    final textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    for (var i = 0; i < members.entries.length; i++) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                members.entries.elementAt(i).key,
                style: textStyle,
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                members.entries.elementAt(i).value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
      if (i != members.entries.length - 1) {
        rows.add(
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Divider(height: 0),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Divider(height: 0),
              ),
            ],
          ),
        );
      }
    }
    return rows;
  }
}