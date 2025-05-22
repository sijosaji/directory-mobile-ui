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
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;
  String? _errorMessage;
  final ScrollController _scrollController = ScrollController();
  UnitFilter selectedFilter = UnitFilter.all;
  String searchText = "";
  static const int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _fetchMembers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMembers({bool loadMore = false}) async {
    if (_isLoading || (!loadMore && !_hasMoreData)) return;

    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        if (!loadMore) {
          _currentPage = 1;
          members = [];
        }
      });

      final filters = <dynamic>[
        if (selectedFilter != UnitFilter.all)
          {
            "type": "fieldFilter",
            "fieldName": "unit",
            "operation": "EQUALS",
            "values": [selectedFilter.name],
          },
        if (searchText.isNotEmpty)
          {
            "type": "fieldFilter",
            "fieldName": "name",
            "operation": "STARTS_WITH",
            "values": [searchText],
          },
      ];

      final requestBody = {
        "pageSize": _pageSize,
        "offset": _currentPage,
        "node": {
          "type": "filterCriteria",
          "evaluationType": "AND",
          "filters": filters
        }
      };

      final response = await http.post(
        Uri.parse('https://prior-kali-sijo-adcd7b71.koyeb.app/api/families/searchFamilyMembers'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      ).timeout(Duration(seconds: 10));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          if (loadMore) {
            members.addAll(data.cast<Map<String, dynamic>>());
          } else {
            members = data.cast<Map<String, dynamic>>();
          }
          _hasMoreData = data.length == _pageSize;
          _currentPage++;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load members: ${response.statusCode}');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      if (searchText != query) {
        searchText = query;
        _hasMoreData = true;
        _fetchMembers();
      }
    });
  }

  void onFilterSelected(UnitFilter filter) {
    if (selectedFilter != filter) {
      selectedFilter = filter;
      _hasMoreData = true;
      _fetchMembers();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      _fetchMembers(loadMore: true);
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
              hintText: 'Search by Head of Name',
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
            child: _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _fetchMembers(),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : members.isEmpty && !_isLoading
                    ? Center(child: Text('No members found'))
                    : ListView.separated(
                        controller: _scrollController,
                        itemCount: members.length + (_hasMoreData ? 1 : 0),
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          if (index == members.length) {
                            return _isLoading
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : SizedBox.shrink();
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/profile.jpeg'),
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
                            subtitle: members[index]['unit'] != null
                                ? Text(getUnitDisplayName(members[index]['unit']), style: TextStyle(color: Colors.grey))
                                : null,
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
