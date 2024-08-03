import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_listing.dart';
import 'profile1.dart';
import 'bottom_nav_bar_with_animation.dart';

class SearchPage extends StatefulWidget {
  final int userId;

  SearchPage({required this.userId});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = '';
  List<dynamic> _listings = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    try {
      final response = await http
          .get(Uri.parse('http://skillswaper.atwebpages.com/get_listings.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>? ?? [];
        setState(() {
          _listings = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print('Error fetching listings: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error fetching listings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Skills', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddListingPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Error fetching listings'))
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by skill or location',
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.search, color: Colors.purple),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchTerm = value.toLowerCase();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: _listings.isEmpty
                          ? Center(child: Text('No listings found'))
                          : ListView.builder(
                              itemCount: _listings.length,
                              itemBuilder: (context, index) {
                                final listing = _listings[index];
                                final skill = listing['skill'] ?? 'N/A';
                                final location = listing['location'] ?? 'N/A';

                                if (_searchTerm.isEmpty ||
                                    skill.toLowerCase().contains(_searchTerm) ||
                                    location
                                        .toLowerCase()
                                        .contains(_searchTerm)) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 20.0),
                                      leading: Icon(
                                        Icons.work,
                                        size: 40,
                                        color: Colors.purple,
                                      ),
                                      title: Text(
                                        skill,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Text(
                                        location,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.purple,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePage1(
                                                userId: widget.userId,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                    ),
                  ],
                ),
      bottomNavigationBar: BottomNavBarWithAnimation(userId: widget.userId),
    );
  }
}
