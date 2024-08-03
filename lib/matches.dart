import 'package:flutter/material.dart';
import 'bottom_nav_bar_with_animation.dart';

class HistoryPage extends StatelessWidget {
  final int userId;

  HistoryPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    // Sample match data
    final List<Map<String, String>> matches = [
      {
        'image1':
            'https://images.unsplash.com/photo-1669707569583-8d4c8051130a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fGNoZWZ8ZW58MHx8MHx8fDA%3D',
        'name1': 'ali',
        'skill1': 'Cooking',
        'image2':
            'https://images.unsplash.com/photo-1518644730709-0835105d9daa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29tcHV0ZXIlMjBtYW58ZW58MHx8MHx8fDA%3D',
        'name2': 'mhmd',
        'skill2': 'Computer Repair',
      },
      {
        'image1':
            'https://images.unsplash.com/photo-1669707569583-8d4c8051130a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fGNoZWZ8ZW58MHx8MHx8fDA%3D',
        'name1': 'ali',
        'skill1': 'Cooking',
        'image2':
            'https://plus.unsplash.com/premium_photo-1688700438084-1936c52670df?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y29tcHV0ZXIlMjBtYW58ZW58MHx8MHx8fDA%3D',
        'name2': 'mahdi',
        'skill2': 'Computer Repair',
      },
      {
        'image1':
            'https://images.unsplash.com/photo-1669707569583-8d4c8051130a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fGNoZWZ8ZW58MHx8MHx8fDA%3D',
        'name1': 'ali',
        'skill1': 'Cooking',
        'image2':
            'https://images.unsplash.com/photo-1516860851503-22e3475fe0be?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBhaW50aW5nJTIwbWFufGVufDB8fDB8fHww',
        'name2': 'george',
        'skill2': 'Painting',
      },
      {
        'image1':
            'https://images.unsplash.com/photo-1669707569583-8d4c8051130a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fGNoZWZ8ZW58MHx8MHx8fDA%3D',
        'name1': 'ali',
        'skill1': 'Cooking',
        'image2':
            'https://images.unsplash.com/photo-1603114595741-e60bf9486e04?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZWxlY3RyaWMlMjBtYW58ZW58MHx8MHx8fDA%3D',
        'name2': 'Issa',
        'skill2': 'mechanic',
      },
      {
        'image1':
            'https://images.unsplash.com/photo-1669707569583-8d4c8051130a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fGNoZWZ8ZW58MHx8MHx8fDA%3D',
        'name1': 'ali',
        'skill1': 'Cooking',
        'image2':
            'https://images.unsplash.com/photo-1603114595741-e60bf9486e04?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZWxlY3RyaWMlMjBtYW58ZW58MHx8MHx8fDA%3D',
        'name2': 'ali',
        'skill2': 'mechanic',
      },
      // Add more matches as needed
    ];

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text('Possible Matches'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.9, // Decrease width to 90% of screen width
              child: Card(
                elevation: 5,
                color: Colors.white70, // Less white background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(match['image1']!),
                            radius: 30,
                          ),
                          SizedBox(height: 6),
                          Text(match['name1']!,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Skill: ${match['skill1']}'),
                        ],
                      ),
                      Icon(
                        Icons.swap_horiz,
                        size: 40,
                        color: Colors.purple,
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(match['image2']!),
                            radius: 30,
                          ),
                          SizedBox(height: 6),
                          Text(match['name2']!,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Skill: ${match['skill2']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWithAnimation(userId: userId),
    );
  }
}
