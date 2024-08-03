import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_listing.dart';
import 'home.dart';
import 'search.dart';
import 'paid_skills.dart';
import 'leaderboard.dart';
import 'profile.dart';
import 'notification.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListingsProvider(prefs),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SkillSWAP',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: prefs.getString('email') != null
            ? HomePage(userId: getUserId())
            : LoginPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomePage(userId: getUserId()),
          '/add': (context) => AddListingPage(userId: getUserId()),
          '/search': (context) => SearchPage(userId: getUserId()),
          '/paid': (context) => PaidSkillsPage(userId: getUserId()),
          '/leaderboard': (context) => LeaderboardPage(userId: getUserId()),
        },
      ),
    );
  }

  int getUserId() {
    // Your logic to get the userId from shared preferences or some other source
    // For example, it might be stored as a string in shared preferences:
    String? userIdString = prefs.getString('userId');
    return userIdString != null
        ? int.parse(userIdString)
        : 0; // Replace 0 with an appropriate default value
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final userId = getUserId(context);

    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/swapper.png',
        height: 55, // adjust the height as needed
      ),
      backgroundColor: Colors.purple,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_active, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(userId: userId),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  int getUserId(BuildContext context) {
    // Use Provider to access userId if applicable, or pass from context
    final listingsProvider =
        Provider.of<ListingsProvider>(context, listen: false);
    return listingsProvider.userId;
  }
}

class ListingsProvider with ChangeNotifier {
  final SharedPreferences prefs;
  List<Map<String, dynamic>> _listings = [];
  int userId = 0; // Initialize userId, modify as necessary

  ListingsProvider(this.prefs) {
    _loadListings();
    _addPredefinedPaidSkills();
    _loadUserId();
  }

  void _loadListings() {
    String? listingsData = prefs.getString('listings');
    if (listingsData != null) {
      _listings = List<Map<String, dynamic>>.from(json.decode(listingsData));
    }
  }

  void _saveListings() {
    prefs.setString('listings', json.encode(_listings));
  }

  void _addPredefinedPaidSkills() {
    if (_listings.isEmpty) {
      _listings.addAll([
        {
          'name': 'Alex',
          'phone': '78822325',
          'email': 'alex43@gmail.com',
          'photo': '',
          'location': 'saida',
          'skill': 'java skills',
          'bio': 'Experienced java programming language',
          'isPaid': true,
          'rating': 5,
          'cost': '70'
        },
        {
          'name': 'Mohammad ',
          'phone': '70241109',
          'email': 'mohammad@gmail.com',
          'photo': '',
          'location': 'tyre',
          'skill': 'shooting ',
          'bio': 'Experienced in shooting birds',
          'isPaid': true,
          'rating': 4,
          'cost': '30'
        },
        {
          'name': 'ALI ',
          'phone': '81551949',
          'email': 'ali123@gmail,com.com',
          'photo': '',
          'location': 'saida',
          'skill': 'Web Development',
          'bio': 'Experienced web developer',
          'isPaid': true,
          'rating': 5,
          'cost': '50'
        },
        {
          'name': 'Alice ',
          'phone': '7050982',
          'email': 'alice@gmail.com',
          'photo': '',
          'location': 'beirut',
          'skill': 'Gardening',
          'bio': 'Let\'s swap gardening tips!',
          'isPaid': false,
          'neededSkill': 'Floral Design'
        },
      ]);
      _saveListings();
    }
  }

  void _loadUserId() {
    String? userIdString = prefs.getString('userId');
    userId = userIdString != null ? int.parse(userIdString) : 0;
  }

  void addListing(String name, String phone, String email, String photo,
      String location, String skill, String bio, bool isPaid, double rating,
      [String? cost, String? neededSkill]) {
    _listings.add({
      'name': name,
      'phone': phone,
      'email': email,
      'photo': photo,
      'location': location,
      'skill': skill,
      'bio': bio,
      'isPaid': isPaid,
      'rating': rating,
      if (isPaid) 'cost': cost,
      if (!isPaid) 'neededSkill': neededSkill,
    });
    _saveListings();
    notifyListeners();
  }

  List<Map<String, dynamic>> get listings => _listings;

  List<Map<String, dynamic>> get paidSkills =>
      _listings.where((listing) => listing['isPaid']).toList();

  List<Map<String, dynamic>> get swapSkills =>
      _listings.where((listing) => !listing['isPaid']).toList();

  List<Map<String, dynamic>> get topRatedSkills =>
      _listings..sort((a, b) => b['rating'].compareTo(a['rating']));

  List<Map<String, dynamic>> get topRatedPaidSkills {
    final sortedPaidSkills = List<Map<String, dynamic>>.from(paidSkills)
      ..sort((a, b) => b['rating'].compareTo(a['rating']));
    return sortedPaidSkills.take(10).toList();
  }
}
