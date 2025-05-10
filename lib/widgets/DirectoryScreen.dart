import 'dart:async';
import 'package:directory/widgets/BottomNavBar.dart';
import 'package:directory/widgets/FamilyProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum UnitFilter {
  all("All"),
  ST_MARY("St.Mary"),
  ST_SEBASTIAN("St.Sebastian"),
  ST_THOMAS("St.Thomas"),
  INFANT_JESUS("Infant Jesus"),
  ST_JOSEPH("St.Joseph"),
  ST_ANTONY("St.Antony"),
  HOLY_FAMILY("Holy Family"),
  LITTLE_FLOWER("Little Flower"),
  ST_GEORGE("St.George");

  final String displayName;
  const UnitFilter(this.displayName);
}

class DirectoryScreen extends StatefulWidget {
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  List<Map<String, dynamic>> members = [];
  Timer? _debounce;
  int offset = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  UnitFilter selectedFilter = UnitFilter.all;

  @override
  void initState() {
    super.initState();
    fetchMembers();
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchMembers({String query = "", bool loadMore = false}) async {
    if (isLoading) return;
    setState(() { isLoading = true; });

    Map<String, dynamic> requestBody = {
      "pageSize": 20,
      "offset": offset,
      "node": {
        "type": "filterCriteria",
        "evaluationType": "AND",
        "filters": []
      }
    };

    if (query.isNotEmpty) {
      requestBody["node"]["filters"].add({
        "type": "filterCriteria",
        "evaluationType": "OR",
        "filters": [
          { "type": "fieldFilter", "fieldName": "name", "operation": "STARTS_WITH", "values": [query] },
          { "type": "fieldFilter", "fieldName": "unit", "operation": "STARTS_WITH", "values": [query] }
        ]
      });
    }

    if (selectedFilter != UnitFilter.all) {
      requestBody["node"]["filters"].add({
        "type": "fieldFilter",
        "fieldName": "unit",
        "operation": "EQUALS",
        "values": [selectedFilter.name]
      });
    }

    final response = await http.post(
      Uri.parse('https://prior-kali-sijo-adcd7b71.koyeb.app/api/families/searchFamilyMembers'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        if (loadMore) {
          members.addAll(data.cast<Map<String, dynamic>>());
        } else {
          members = data.cast<Map<String, dynamic>>();
        }
        offset++;
        isLoading = false;
      });
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(seconds: 1), () {
      offset = 1;
      fetchMembers(query: query);
    });
  }

  void onFilterSelected(UnitFilter filter) {
    setState(() {
      selectedFilter = filter;
      offset = 1;
    });
    fetchMembers();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchMembers(loadMore: true);
    }
  }

  String getUnitDisplayName(String? unit) {
    if (unit == null) return "";
    return UnitFilter.values.firstWhere((e) => e.name == unit, orElse: () => UnitFilter.all).displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search by Head of Family, Unit',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: UnitFilter.values.map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter.displayName),
                    selected: selectedFilter == filter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onSelected: (val) => onFilterSelected(filter),
                  ),
                )).toList(),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: members.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/login_background.jpg'),
                  ),
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FamilyProfile(familyId: members[index]['familyId']),
                        ),
                      );
                    },
                  title: Text(
                    members[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: members[index]['unit'] != null ? Text(getUnitDisplayName(members[index]['unit']), style: TextStyle(color: Colors.grey)) : null,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        parentContext: context,
      ),
    );
  }
}
