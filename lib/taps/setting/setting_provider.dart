import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  SettingProvider() {
    getTheme();
    getLanguage();
  }
  void changeTheme(ThemeMode selectedTheme) {
     if (selectedTheme==themeMode) return;
    themeMode = selectedTheme;
    savedTheme(themeMode);
    notifyListeners();
  }
  String language = 'en';
  void changeLanguage(String selectedLanguage) {
    if (selectedLanguage == language) return;
    language = selectedLanguage;
    savedLanguage(language);
    notifyListeners();
  }

  void savedTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (theme == ThemeMode.light) {
      prefs.setString('theme', 'light');
    } else {
      prefs.setString('theme', 'dark');
    }
  }

  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedTheme = prefs.getString('theme') ?? 'light';
    if (cachedTheme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  void savedLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (lang == 'en') {
      prefs.setString('language', 'en');
    } else {
      prefs.setString('language', 'ar');
    }
  }

  void getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedLanguage = prefs.getString('language') ?? 'en';
    if (cachedLanguage == 'en') {
      language = 'en';
    } else {
      language = 'ar';
    }
    notifyListeners();
  }
}
