import 'package:equatable/equatable.dart';
import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';

abstract class NewsBlocState extends Equatable {}

class NewsBlocInitial extends NewsBlocState {
  @override
  List<Object?> get props => [];
}


class Loading extends NewsBlocState {
  @override
  List<Object?> get props => [];
}

class Loaded extends NewsBlocState {
  final List<NewsArticle?> newsArticle;
  Loaded({required this.newsArticle});

  @override
  List<Object?> get props => [newsArticle];
}

class Error extends NewsBlocState {
  final String message;
  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
