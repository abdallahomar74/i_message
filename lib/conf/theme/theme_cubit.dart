import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'light_mode.dart'; // Adjust the import path as needed
import 'dark_mode.dart'; // Adjust the import path as needed

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? darkMode : lightMode);
  }

  void toggleTheme() async {
    final isDarkMode = state == lightMode;
    final newTheme = isDarkMode ? darkMode : lightMode;
    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}