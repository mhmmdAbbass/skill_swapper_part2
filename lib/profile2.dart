import 'package:flutter/material.dart';
import 'main.dart';
import 'bottom_nav_bar_with_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'message_me.dart';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfilePage2 extends StatelessWidget {
  final Map<String, dynamic> listing;

  ProfilePage2({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF673AB7),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
                  image: listing['image'] != null && listing['image'] != ''
                      ? DecorationImage(
                          image: MemoryImage(base64Decode(listing['image'])),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: listing['image'] == null || listing['image'] == ''
                    ? Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey[700],
                      )
                    : null,
              ),
              SizedBox(height: 20),

              // User Information
              _buildInfoCard('Name', listing['name']),
              _buildInfoCard('Phone', listing['phone']),
              _buildInfoCard('Email', listing['email']),
              _buildInfoCard('Location', listing['location']),
              _buildInfoCard('Skill', listing['skill']),
              // Display the skills to swap
              if (listing['neededSkill'] != null &&
                  listing['neededSkill'] != '')
                _buildInfoCard('Skills to Swap', listing['neededSkill']),
              _buildInfoCard('Bio', listing['bio']),
              if (listing['isPaid']) _buildInfoCard('Cost', listing['cost']),
              // Rating display
              _buildRatingCard('Rating', listing['rating']),

              SizedBox(height: 30),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    Icons.call,
                    'Call',
                    () async {
                      final url = 'tel:${listing['phone']}';
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
                      final url = 'mailto:${listing['email']}';
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
                            builder: (context) => MessageMePage()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
          Expanded(
            child: RatingBarIndicator(
              rating: value ?? 0.0,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
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
