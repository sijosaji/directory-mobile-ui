import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserMetadataProvider with ChangeNotifier {
  Map<String, dynamic> _userMetadata = {};

  Map<String, dynamic> get userMetadata => _userMetadata;

  // Load metadata from shared preferences
  Future<void> loadUserMetadata() async {
    final prefs = await SharedPreferences.getInstance();
    final String? metadataString = prefs.getString('user_metadata');
    
    if (metadataString != null && metadataString.isNotEmpty) {
      _userMetadata = Map<String, dynamic>.from(json.decode(metadataString));
    } else {
      _userMetadata = {};
    }

    notifyListeners();
  }

  // Set user metadata
  Future<void> setUserMetadata(Map<String, dynamic> metadata) async {
    _userMetadata = metadata;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_metadata', json.encode(metadata));  // Save metadata to shared preferences
    notifyListeners();
  }

  // Clear user metadata on logout
  Future<void> logout() async {
    _userMetadata = {};
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_metadata');
    notifyListeners();
  }
}
