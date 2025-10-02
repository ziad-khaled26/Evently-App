import 'package:evently_app/core/resources/constants/cache_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;
  static Future<void> init()async{
     prefs=await SharedPreferences.getInstance();

  }

  static void saveTheme(ThemeMode newTheme) {
    prefs.setString(CacheConstant.themeKey, newTheme ==ThemeMode.light?"Light":"Dark");
  }

  static ThemeMode? getTheme(){
    String? theme=prefs.getString(CacheConstant.themeKey);
    if(theme!=null){
      return theme=="Light"? ThemeMode.light:ThemeMode.dark;
    }
    return null;

  }

  static saveLanguage(Locale newLanguage){
    String language=newLanguage==Locale("en")?"English":"Arabic";
    prefs.setString(CacheConstant.languageKey, language);
  }

  static Locale? getSavedLanguage(){
    String? language=prefs.getString(CacheConstant.languageKey);
    if(language!=null){
      return Locale(language=="English"?"en":"ar");
    }
    return null;
  }
}