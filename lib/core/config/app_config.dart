
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/news_category_helper.dart';

class AppConfig {
  static const String baseUrl = 'https://newsapi.org/v2/';

  static const String apiKey = '54598d169fc44c0a9d77fda6a7ed48df';
  //url format baseurl+newscategory+apikey
}

class UrlPreferences {
  static SharedPreferences? sharedPreferences;
  // ignore: non_constant_identifier_names
  static String NEWS_URL = 'Caterory_Url';
  

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setNewsUrl(String categoryUrl) {
    sharedPreferences!.setString(NEWS_URL, categoryUrl);
  }

  static String getNewsUrl() {
    final String? newsUrl = sharedPreferences?.getString(NEWS_URL);
    if (newsUrl == null) {
      return NewsCategoryHelper().apple();
    }
    return newsUrl;
  }
}