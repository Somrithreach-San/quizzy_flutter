// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  late final SharedPreferences storage;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    storage.setInt("selectedIndex", index);
    notifyListeners();
  }

  final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Color.fromARGB(255, 65, 65, 65),
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300,
    ),
  );

  final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.white,
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
  ));

  void changeTheme() {
    _isDark = !_isDark;
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
    _selectedIndex = storage.getInt("selectedIndex") ?? 0;
    _isDark = storage.getBool("isDark") ?? false;
    print("Initial theme: ${_isDark ? 'Dark' : 'Light'}");
    _selectedIndex = storage.getInt("selectedIndex") ?? 0;
    notifyListeners();
  }

  void saveSelectedIndex(int index) {
    _selectedIndex = index;
    storage.setInt("selectedIndex", index);
    notifyListeners();
  }
}
