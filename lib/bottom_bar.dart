import 'package:flutter/material.dart';
import 'package:skill_swaper/profile2.dart';
import 'home.dart';
import 'search.dart';
import 'add_listing.dart';
import 'matches.dart';
import 'profile.dart';

class BottomNavBarWithAnimation extends StatefulWidget {
  final int userId;

  BottomNavBarWithAnimation({required this.userId});

  @override
  _BottomNavBarWithAnimationState createState() =>
      _BottomNavBarWithAnimationState();
}

class _BottomNavBarWithAnimationState extends State<BottomNavBarWithAnimation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.forward(from: 0);
    });

    // Navigation logic based on the selected index
    switch (index) {
      case 0:
        _navigateToPage(HomePage(
            userId: widget.userId)); // Use a helper function for navigation
        break;
      case 1:
        _navigateToPage(SearchPage(userId: widget.userId));
        break;
      case 2:
        _navigateToPage(AddListingPage(userId: widget.userId));
        break;
      case 3:
        _navigateToPage(HistoryPage(userId: widget.userId));
        break;
      case 4:
        _navigateToPage(ProfilePage2(listing: const {}));
        break;
    }
  }

  // Helper function to navigate to a page
  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then((value) {
      // Rebuild the widget after navigation to refresh the selected index
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          painter: CurvedPainter(),
          child: Container(height: 60),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF9C27B0),
                Color(0xFFD1C4E9),
              ],
            ),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: ScaleTransition(
                  scale: _animation,
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 60,
                    color: Colors.purple.shade600,
                  ),
                ),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horizontal_circle_outlined),
                label: 'Matches',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, 0);

    double waveHeight = 20;
    double waveWidth = size.width / 5;

    for (int i = 0; i < 5; i++) {
      path.quadraticBezierTo(waveWidth * (i + 0.5),
          i % 2 == 0 ? waveHeight : -waveHeight, waveWidth * (i + 1), 0);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
