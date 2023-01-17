//Entity user need to define first

import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  const NewsArticle({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

class Source extends Equatable {
  const Source({
    this.id,
    this.name,
  }) : super();

  final dynamic id;
  final String? name;

  

  @override
  List<Object?> get props => [id, name];
}
