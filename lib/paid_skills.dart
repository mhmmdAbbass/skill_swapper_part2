import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bottom_nav_bar_with_animation.dart';
import 'profile.dart';
import 'add_listing.dart';

class PaidSkillsPage extends StatefulWidget {
  final int userId;

  PaidSkillsPage({required this.userId});

  @override
  _PaidSkillsPageState createState() => _PaidSkillsPageState();
}

class _PaidSkillsPageState extends State<PaidSkillsPage> {
  List<dynamic> _paidSkills = [];
  bool _isLoading = true;
  String _errorMessage = ''; // Store error messages

  @override
  void initState() {
    super.initState();
    _fetchPaidSkills();
  }

  Future<void> _fetchPaidSkills() async {
    try {
      final response = await http.get(
          Uri.parse('http://skillswaper.atwebpages.com/get_paid_skills.php'));

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('success') && data['success'] == true) {
          if (data.containsKey('data') && data['data'] is List) {
            setState(() {
              _paidSkills = data['data'];
              _isLoading = false;
            });
          } else {
            setState(() {
              _errorMessage =
                  'Data format incorrect: Missing or invalid "data" array';
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _errorMessage =
                'Error fetching data: ${data['message'] ?? 'Unknown error'}';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paid Skills', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.black,
            hoverColor: Colors.blue,
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
          : _errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: _paidSkills.length,
                  itemBuilder: (context, index) {
                    final skill = _paidSkills[index]['skill'] ?? 'N/A';
                    final cost = _paidSkills[index]['cost'] ?? 'N/A';

                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                          'Cost: $cost',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
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
                                builder: (context) => ProfilePage(
                                    userId: widget.userId,
                                    listing: _paidSkills[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavBarWithAnimation(userId: widget.userId),
    );
  }
}
