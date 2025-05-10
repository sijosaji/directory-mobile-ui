// lib/providers/UserMetadataProvider.dart
import 'package:flutter/material.dart';

class UserMetadataProvider with ChangeNotifier {
  Map<String, dynamic> _userMetadata = {};

  Map<String, dynamic> get userMetadata => _userMetadata;

  void setUserMetadata(Map<String, dynamic> metadata) {
    _userMetadata = metadata;
    notifyListeners();
  }
}
