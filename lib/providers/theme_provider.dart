import 'package:evently_app/core/prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme=PrefsManager.getTheme()??ThemeMode.light;

  void changeAppTheme(ThemeMode newTheme){
    if(currentTheme==newTheme) return;
    currentTheme=newTheme;
    PrefsManager.saveTheme(currentTheme);
    notifyListeners();

  }


  bool get isDarkEnabled=>currentTheme==ThemeMode.dark;

}