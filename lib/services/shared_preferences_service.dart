// lib/services/shared_preferences_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> saveUserData({
    required String email,
    required String password,
    required String name,
    required String birthday,
    required String phoneNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('name', name);
    await prefs.setString('birthday', birthday);
    await prefs.setString('phoneNumber', phoneNumber);
  }

  static Future<Map<String, String>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final name = prefs.getString('name');
    final birthday = prefs.getString('birthday');
    final phoneNumber = prefs.getString('phoneNumber');

    if (email != null &&
        password != null &&
        name != null &&
        birthday != null &&
        phoneNumber != null) {
      return {
        'email': email,
        'password': password,
        'name': name,
        'birthday': birthday,
        'phoneNumber': phoneNumber,
      };
    }
    return null;
  }
}
