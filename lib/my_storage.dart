import 'dart:convert';

import 'package:fluttershareexpense/expense_group.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStorage{

  static const String KEY_LANGUAGE= "KEY_LANGUAGE";

  static Future setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_LANGUAGE, language);
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString(KEY_LANGUAGE) ?? MyLanguage.ENGLISH;
    return language;
  }

}