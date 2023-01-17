import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_api/core/error/failure.dart';
import 'package:news_app_api/core/usecase/usecase.dart';
import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';
import 'package:news_app_api/src/news_app/domain/repositories/news_article_repository.dart';

class GetNewsConcreteArticle implements UseCase<List<NewsArticle?>, Params> {
  final NewsArticleRepository repository;

  GetNewsConcreteArticle(this.repository);

  @override
  Future<Either<Failure, List<NewsArticle?>>> call(Params params) async {
    return repository.getConcreteArticles(params.category);
  }
}

class Params extends Equatable {
  final String category;
  const Params({required this.category});

  @override
  List<Object?> get props => [category];
}
