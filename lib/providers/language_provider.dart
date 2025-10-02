import 'package:evently_app/core/prefs_manager.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  Locale currentLanguage=PrefsManager.getSavedLanguage()??Locale("ar");

  void changeAppLanguage(Locale newLanguage){
    if(currentLanguage==newLanguage)return;
    currentLanguage=newLanguage;
    PrefsManager.saveLanguage(currentLanguage);
    notifyListeners();
  }

  bool get isEnglishEnabled=> currentLanguage==Locale("en");

}