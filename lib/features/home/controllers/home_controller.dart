import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';

class HomeController with ChangeNotifier {
  String? userName = 'Guest';
  bool isLoading = true;

  String? userImagePath;
  void init() {
    loadUserData();
  }

  void loadUserData() async {
    userName = PreferenceManger().getString(StorageKey.userName);
    userImagePath = PreferenceManger().getString(StorageKey.userImage);
    notifyListeners();
  }
}
