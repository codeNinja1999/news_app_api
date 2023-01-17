import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';

class NewsApi {
    NewsApi({
        this.status,
        this.totalResults,
        this.articles,
    });

    final String? status;
    final int? totalResults;
    final List<Article?>? articles;

    factory NewsApi.fromJson(Map<String, dynamic> json) => NewsApi(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null ? [] : List<Article?>.from(json["articles"]!.map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x!.toJson())),
    };
}

class Article extends NewsArticle {
   const Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;


  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: SourceModel.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}

class SourceModel extends Source {
  const SourceModel({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
