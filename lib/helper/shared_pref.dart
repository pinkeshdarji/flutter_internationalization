import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

const String selectedLang = "selectedLang";

Future setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(selectedLang, languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(selectedLang) ?? 'en';
  return Locale(languageCode);
}
