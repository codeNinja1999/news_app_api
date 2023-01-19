import 'dart:convert';
import 'package:news_app_api/core/config/app_config.dart';
import 'package:news_app_api/core/config/news_category/news_category_url.dart';
import 'package:news_app_api/core/error/exception.dart';
import 'package:news_app_api/core/error/failure.dart';
import 'package:news_app_api/src/news_app/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsArticleRemoteDatasource {
  Future<List<Article?>> getNewsArticle();
}

class NewsArticleRemoteDatasourceImpl implements NewsArticleRemoteDatasource {
  final http.Client client;
  NewsArticleRemoteDatasourceImpl({required this.client});

  @override
  Future<List<Article?>> getNewsArticle() => _getRandomArticleFromCategory();

  Future<List<Article?>> _getRandomArticleFromCategory() async {
    
    try {
      List<Article?> articles = [];

      const String url = AppConfig.baseUrl + NewsCategoryUrl.appleUrl + AppConfig.apiKey;
      final response = await client.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // {status,totalresult,articles[{source{id,name},author,title,url,content}],}

        String? status = NewsApi.fromJson(json).status;

        if (status == "ok") {
          var body = json['articles'];
          //article[{source[id,name],author,title,url,content},{source[id,name],author,title,url,content}]

          if (body != null) {
            articles =
                body.map<Article?>((item) => Article.fromJson(item)).toList();
            return articles;
          }
          //[source, author, title, url, content]
        }
      }
      return articles;
    } on ServerException {
      throw ServerFailure('Failed to load data from API');
    } on SocketException {
      throw NetworkDisconnected('No internet Connection');
    } catch (e) {
      rethrow;
    }
  }
}
