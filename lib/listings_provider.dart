import 'package:flutter/material.dart';

class ListingsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _listings = [];

  List<Map<String, dynamic>> get listings => _listings;

  void addListing(String skill, {String? requiredSkill, String? cost}) {
    final newListing = {
      'skill': skill,
      'requiredSkill': requiredSkill,
      'cost': cost,
    };
    _listings.add(newListing);
    notifyListeners();
  }
}
