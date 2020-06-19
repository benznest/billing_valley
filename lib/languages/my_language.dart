import 'package:fluttershareexpense/languages/en.dart';
import 'package:fluttershareexpense/languages/th.dart';
import 'package:fluttershareexpense/my_application.dart';
import 'package:fluttershareexpense/my_storage.dart';

class MyLanguage {
  static const String THAI = "th";
  static const String ENGLISH = "en";

  static Future<Map<String, String>> getDictionary(String language) async {
    if (language == THAI) {
      return MyThai.dictionary;
    } else if (language == ENGLISH) {
      return MyEnglish.dictionary;
    }
    return MyEnglish.dictionary;
  }

  static get dictionary => MyApplication.dictionary;

  static changeLanguage(String language) async {
    await MyStorage.setLanguage(language);
    MyApplication.currentLanguage = language;
    MyApplication.dictionary = await getDictionary(language);
  }
}
