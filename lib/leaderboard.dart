import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'dart:convert';
import 'bottom_nav_bar_with_animation.dart';
import 'profile2.dart'; // Import the ProfilePage

class LeaderboardPage extends StatelessWidget {
  final int userId;

  LeaderboardPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    final listingsProvider = Provider.of<ListingsProvider>(context);
    final top10PaidSkills = listingsProvider.topRatedPaidSkills;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top 10 Paid Skills',
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
        child: ListView.builder(
          padding: EdgeInsets.all(20.0),
          itemCount: top10PaidSkills.length,
          itemBuilder: (context, index) {
            final skill = top10PaidSkills[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.work, color: Colors.purple),
                title: Text(skill['skill']),
                subtitle: Text(skill['location']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text('${skill['rating']}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage2(
                                    listing: const {},
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
