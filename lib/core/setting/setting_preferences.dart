// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SettingPreferences {
  static SharedPreferences? sharedPreferences;
  static String HOME_KEY = 'Show_Home';
  

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setHomeKey(bool showhome) {
    sharedPreferences!.setBool(HOME_KEY, showhome);
  }

  static bool getHomeKey() {
    final bool? homeKey = sharedPreferences?.getBool(HOME_KEY);
    if (homeKey == null) {
      return false;
    }
    return homeKey;
  }
}
