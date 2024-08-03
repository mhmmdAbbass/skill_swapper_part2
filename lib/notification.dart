import 'package:flutter/material.dart';
import 'main.dart';
import 'bottom_nav_bar_with_animation.dart';

class NotificationPage extends StatelessWidget {
  final int userId;

  NotificationPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
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
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildNotificationCard(
              context,
              'Skill Match!',
              'Your skill in Programming matches with Sarah\'s need for a website developer. Check it out!',
              Icon(Icons.code, size: 40, color: Colors.blue),
            ),
            _buildNotificationCard(
              context,
              'New Message',
              'John sent you a message about your carpentry skills.',
              Icon(Icons.message, size: 40, color: Colors.green),
            ),
            _buildNotificationCard(
              context,
              'Skill in Demand',
              'Your photography skills are in high demand in your area! Update your profile to attract more users.',
              Icon(Icons.camera_alt, size: 40, color: Colors.red),
            ),
            _buildNotificationCard(
              context,
              'Welcome to SkillSwap!',
              'Start exploring and connecting with people who share your interests or need your skills.',
              Icon(Icons.handshake, size: 40, color: Colors.orange),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAnimation(userId: userId),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, String title, String message, Icon icon) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Add navigation logic when the notification is tapped
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 16.0),
                child: icon,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      message,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
