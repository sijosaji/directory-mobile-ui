import 'package:flutter/material.dart';
import 'HeaderSection.dart';

class UnitDetails extends StatefulWidget {
  final String? selectedUnitName;

  const UnitDetails({Key? key, this.selectedUnitName}) : super(key: key);

  @override
  _UnitDetailsState createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  final List<Map<String, String>> units = [
    {"name": "St. Mary's", "image": "assets/st_mary_large.png"},
    {"name": "St. George", "image": "assets/st_george_large.png"},
    {"name": "Infant Jesus", "image": "assets/infant_jesus_large.png"},
    {"name": "St. Thomas", "image": "assets/st_thomas_large.png"},
    {"name": "Holy Family", "image": "assets/holy_family_large.png"},
    {"name": "St. Sebastian", "image": "assets/st_sebastian_large.png"},
    {"name": "Little Flower", "image": "assets/little_flower_large.png"},
    {"name": "St. Joseph", "image": "assets/st_joseph_large.png"},
    {"name": "St. Antony", "image": "assets/st_antony_large.png"},
  ];

  late Map<String, String> selectedUnit;
  final ScrollController _unitScrollController = ScrollController();

  final Map<String, Map<String, Map<String, String>>> allUnitData = {
    "St. Thomas": {
      "Unit Representatives": {
        "President": "Jomon CJ",
        "Vice President": "Thomas Peter",
        "Secretary": "Mini Varghese",
        "Joint Secretary": "Ancy Antony",
        "Treasurer": "Daisy Dominic",
        "Joint Treasurer": "NA",
      },
      "Mathruvedi": {
        "President": "Sali Joychan",
        "Treasurer": "Mini Joby",
      },
      "Pithruvedi": {
        "President": "Thomas KJ",
        "Treasurer": "Bose V Abraham",
      },
      "Nurses Guild": {
        "President": "Hilda Ann Jose",
      }
    },
    "Holy Family": {
      "Unit Representatives": {
        "President": "Shaji VT",
        "Vice President": "Usha Rajendran",
        "Secretary": "Jose Maliakan",
        "Joint Secretary": "Sophy Bijumon",
        "Treasurer": "Antony Xavier",
      },
      "Mathruvedi": {
        "President": "Thushara Jomon",
        "Secretary": "Elsy Varghese",
        "Treasurer": "Lalji Tijo",
      },
      "Pithruvedi": {
        "President": "Jomon Thomas",
        "Secretary": "Sabu Matthew",
        "Treasurer": "Antony Xavier",
      },
      "Nurses Guild": {
        "President": "Mary Shaji",
      }
    },
    "Little Flower": {
      "Unit Representatives": {
        "President": "Leena Bobby",
        "Vice President": "Saji PJ",
        "Secretary": "Saju Philp",
        "Joint Secretary": "Vigi Abraham",
        "Treasurer": "Abraham Thomas",
      },
      "Mathruvedi": {
        "President": "Jolly Thomas",
        "Treasurer": "Sophy Sunil",
      },
      "Pithruvedi": {
        "President": "Sunil K George",
        "Treasurer": "Bobby Koshi",
      },
      "Nurses Guild": {
        "President": "Jenny Sunil",
      }
    },
    "St. Sebastian": {
      "Unit Representatives": {
        "President": "Manoj KV",
        "Vice President": "Lincy Jojo",
        "Secretary": "Tony J Pullappally",
        "Joint Secretary": "Soumya Sunoj",
        "Treasurer": "Sunoj Jose",
      },
      "Mathruvedi": {
        "President": "Jolly Johnson",
        "Secretary": "Anu Vibin",
        "Treasurer": "Jiji Saji",
      },
      "Pithruvedi": {
        "President": "Joshy Kurian",
        "Secretary": "Joji Mathew",
        "Treasurer": "Johnson TK",
      },
      "Nurses Guild": {
        "President": "Dolly Joji",
      }
    },
    "St. George": {
      "Unit Representatives": {
        "President": "Jessy Mathew",
        "Vice President": "Jacob Mathew",
        "Secretary": "Mrudula Sanal",
        "Joint Secretary": "Jomon George",
        "Treasurer": "Jose KJ",
      },
      "Mathruvedi": {
        "President": "Ancy Sabu",
        "Secretary": "Bindu Johny",
        "Treasurer": "Deena Bijoy",
      },
      "Pithruvedi": {
        "President": "Joby Mathew",
        "Secretary": "Thomaskutty NA",
        "Treasurer": "Sijoy Thomas",
      },
      "Nurses Guild": {
        "President": "Shanti Abraham",
      }
    },
    "St. Mary's": {
      "Unit Representatives": {
        "President": "Gigi Varghese",
        "Vice President": "Jaisy Roy",
        "Secretary": "Thankchan T",
        "Joint Secretary": "Leelamma Benny",
        "Treasurer": "Viju KM",
      },
      "Mathruvedi": {
        "President": "Biji Aarvin",
        "Secretary": "Joby Viju",
        "Treasurer": "Mercy James",
      },
      "Pithruvedi": {
        "President": "George Varkey",
        "Secretary": "Sibi Jose",
        "Treasurer": "Varghese Scariya",
      },
      "Nurses Guild": {
        "President": "Sherly Shinoy",
      }
    },
    "Infant Jesus": {
      "Unit Representatives": {
        "President": "Tony Mathew",
        "Vice President": "Sophia Franics",
        "Secretary": "Anu Netto",
        "Joint Secretary": "Thomas TK",
        "Treasurer": "Sabu Joseph",
      },
      "Mathruvedi": {
        "President": "Beena Xavier",
        "Secretary": "Jessy Sabu",
        "Treasurer": "Saramma Baby",
      },
      "Pithruvedi": {
        "President": "Raju P Mathew",
        "Secretary": "Mathew PJ",
        "Treasurer": "Sabu Joseph",
      },
      "Nurses Guild": {
        "President": "Dinil P Joy",
      }
    },
    "St. Joseph": {
  "Unit Representatives": {
    "President": "Martin CA",
    "Vice President": "Elsy Johnson",
    "Secretary": "Deepa Jose",
    "Joint Secretary": "Johnson Joseph",
    "Treasurer": "Josphine James",
  },
  "Mathruvedi": {
    "President": "Jainy Thomas",
    "Secretary": "Greeshma"
  },
  "Pithruvedi": {
    "President": "Biju KV",
    "Secretary": "Jijo Jose"
  },
  "Nurses Guild": {
    "President": "Mini James",
  }
},
"St. Antony": {
  "Unit Representatives": {
    "President": "Cicilly Augustine",
    "Vice President": "Saji Dominic",
    "Secretary": "Ruby Rocky",
    "Joint Secretary": "Mini Antony",
    "Treasurer": "A. Antony ",
  },
  "Mathruvedi": {
    "President": "Tintu Saji",
    "Secretary": "Lissy George"
  },
  "Pithruvedi": {
    "President": "Rocky KM",
    "Secretary": "Jolly Chetan",
    "Treasurer": "Sony Joseph",
  },
  "Nurses Guild": {
    "President": "Mini Antony",
  }
},

  };

  @override
  void initState() {
    super.initState();
    final matchingUnit = units.firstWhere(
      (unit) => unit["name"] == widget.selectedUnitName,
      orElse: () => units.first,
    );
    selectedUnit = Map<String, String>.from(matchingUnit);
  }

  void _changeUnitBySwipe(bool isLeft) {
    int currentIndex = units.indexWhere((unit) => unit["name"] == selectedUnit["name"]);
    int newIndex = currentIndex;
    if (isLeft && currentIndex < units.length - 1) {
      newIndex = currentIndex + 1;
    } else if (!isLeft && currentIndex > 0) {
      newIndex = currentIndex - 1;
    }
    if (newIndex != currentIndex) {
      setState(() {
        selectedUnit = Map<String, String>.from(units[newIndex]);
      });
      _scrollToUnit(newIndex);
    }
  }

  void _scrollToUnit(int index) {
    // Each unit button is about 120px wide including padding, adjust as needed
    double offset = (index * 120.0) - 60.0; // Center the selected unit
    _unitScrollController.animateTo(
      offset < 0 ? 0 : offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUnitData = allUnitData[selectedUnit["name"]] ?? {};

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
                      controller: _unitScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: units.map((unit) {
                          bool isSelected = (unit["name"] == selectedUnit["name"]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedUnit = Map<String, String>.from(unit);
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
                                  unit["name"]!,
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
                    if (details.primaryVelocity! < 0) {
                      // Swiped Left
                      _changeUnitBySwipe(true);
                    } else if (details.primaryVelocity! > 0) {
                      // Swiped Right
                      _changeUnitBySwipe(false);
                    }
                  }
                },
                child: SingleChildScrollView(
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
                                selectedUnit["image"]!,
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
                                    selectedUnit["name"]!,
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
                          children: currentUnitData.entries.map((section) {
                            final labelTexts = section.value.keys.toList();
                            final textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
                            final textPainters = labelTexts.map((label) => TextPainter(
                              text: TextSpan(text: label, style: textStyle),
                              maxLines: 1,
                              textDirection: TextDirection.ltr,
                            )..layout()).toList();
                            final maxLabelWidth = textPainters.map((tp) => tp.width).fold<double>(0, (a, b) => a > b ? a : b);

                            List<TableRow> rows = [];
                            for (var i = 0; i < section.value.entries.length; i++) {
                              rows.add(
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        section.value.entries.elementAt(i).key,
                                        style: textStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        section.value.entries.elementAt(i).value,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (i != section.value.entries.length - 1) {
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

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    section.key,
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
                                      0: FixedColumnWidth(maxLabelWidth + 24),
                                      1: FlexColumnWidth(),
                                    },
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    children: rows,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
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
}