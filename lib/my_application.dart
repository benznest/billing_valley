import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/my_storage.dart';

class MyApplication {
  static String APP_NAME = "Billing Valley";
  static String GITHUB_URL = "https://github.com/benznest/billing_valley";
  static String DEVELOPER_NAME = "benzneststudios";
  static String VERSION = "6.0";
  static String currentLanguage;
  static Map<String, String> dictionary;

  static init() async {
    currentLanguage = await MyStorage.getLanguage();
    dictionary = await MyLanguage.getDictionary(currentLanguage);
  }
}
