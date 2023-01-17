import 'dart:convert';
import 'package:news_app_api/core/config/app_config.dart';
import 'package:news_app_api/core/error/exception.dart';
import 'package:news_app_api/core/error/failure.dart';
import 'package:news_app_api/src/news_app/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsArticleConcreteDatasource {
  Future<List<Article?>> getNewsConcreteArticle(String category);
}

class NewsArticleConcreteDatasourceImpl
    implements NewsArticleConcreteDatasource {
  final http.Client client;
  NewsArticleConcreteDatasourceImpl({required this.client});

  @override
  Future<List<Article?>> getNewsConcreteArticle(String category) =>
      _getNewsConcreteArticle(category);

  Future<List<Article?>> _getNewsConcreteArticle(String category) async {
    try {
      List<Article?> articles = [];
      final String url = AppConfig.baseUrl + category + AppConfig.apiKey;
      final response = await client.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // {status,totalresult,articles[{source{id,name},author,title,url,content}],}
        var status = NewsApi.fromJson(json).status;

        if (status == "ok") {
          var body = json['articles'];
          //article[{source[id,name],author,title,url,content},{source[id,name],author,title,url,content}]

          if (body != null) {
            articles =
                body.map<Article?>((item) => Article.fromJson(item)).toList();
            return articles;
          }
          return [];
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
