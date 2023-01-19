
import 'package:news_app_api/core/theme/app_theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;
  static String themeKey = "Key_Theme_Preferences";

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void setTheme(AppTheme selectedTheme) {
    String theme = selectedTheme.toString();
    preferences!.setString(themeKey, theme);
  }

  static AppTheme getTheme() {
    final String? theme = preferences?.getString(themeKey);
    if (theme == null) return AppTheme.light;

    return getSelectedTheme(theme);
  }

  static AppTheme getSelectedTheme(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return AppTheme.dark;
  }
}
