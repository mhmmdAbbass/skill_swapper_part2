import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'message_me.dart';
import 'bottom_nav_bar_with_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage1 extends StatefulWidget {
  final int userId;

  ProfilePage1({required this.userId});

  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yourserver.com/get_user_data.php?userId=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          if (jsonData['success']) {
            setState(() {
              userData = jsonData['data'];
              isLoading = false;
            });
          } else {
            // Handle server error message
            print('Error from server: ${jsonData['message']}');
            setState(() {
              isLoading = false;
            });
          }
        } catch (e) {
          print('Error parsing JSON: $e');
          print('Response body: ${response.body}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Server error: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF673AB7),
                    Color(0xFF9C27B0),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(75),
                        image:
                            userData['image'] != null && userData['image'] != ''
                                ? DecorationImage(
                                    image: MemoryImage(
                                        base64Decode(userData['image'])),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                      child:
                          userData['image'] == null || userData['image'] == ''
                              ? Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey[700],
                                )
                              : null,
                    ),
                    SizedBox(height: 10),

                    // User Information
                    _buildInfoCard('Name', userData['name']),
                    _buildInfoCard('Phone', userData['phone']),
                    _buildInfoCard('Email', userData['email']),
                    _buildInfoCard('Location', userData['location']),
                    _buildInfoCard('Skill', userData['skill']),
                    _buildInfoCard('Bio', userData['bio']),
                    _buildRatingCard('Rating', userData['rating']),

                    SizedBox(height: 30),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildActionButton(
                          Icons.call,
                          'Call',
                          () async {
                            final url = 'tel:${userData['phone']}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        _buildActionButton(
                          Icons.email,
                          'Email',
                          () async {
                            final url = 'mailto:${userData['email']}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        _buildActionButton(
                          Icons.message,
                          'Message',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MessageMePage()), // Define MessageMePage
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavBarWithAnimation(userId: widget.userId),
    );
  }

  // Helper function to build information cards
  Widget _buildInfoCard(String label, String? value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build rating card
  Widget _buildRatingCard(String label, double? value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build action buttons
  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Color(0xFF673AB7)),
      label: Text(
        label,
        style: TextStyle(color: Color(0xFF673AB7)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
