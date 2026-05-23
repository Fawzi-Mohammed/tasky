import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';

class HomeController with ChangeNotifier {
  String? userName = 'Guest';
  bool isLoading = true;

  String? userImagePath;
  void init() {
    loadUserData();
  }

  void loadUserData() async {
    userName = PreferenceManager().getString(StorageKey.userName);
    userImagePath = PreferenceManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
