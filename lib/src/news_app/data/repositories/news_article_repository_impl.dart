import 'package:dartz/dartz.dart';
import 'package:news_app_api/core/error/exception.dart';
import 'package:news_app_api/core/error/failure.dart';
import 'package:news_app_api/core/network/network_info.dart';
import 'package:news_app_api/src/news_app/data/data_source/news_article_concrete_datasource.dart';
import 'package:news_app_api/src/news_app/data/data_source/news_article_remote_datasource.dart';
import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';
import 'package:news_app_api/src/news_app/domain/repositories/news_article_repository.dart';

class NewsArticleRepositoryImpl implements NewsArticleRepository {
  final NetworkInfo networkInfo;
  final NewsArticleRemoteDatasource newsArticleRemoteDatasource;
  final NewsArticleConcreteDatasource newsArticleConcreteDatasource;

  NewsArticleRepositoryImpl(
      {required this.networkInfo,
      required this.newsArticleRemoteDatasource,
      required this.newsArticleConcreteDatasource});

  @override
  Future<Either<Failure, List<NewsArticle?>>> getArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final articleList = await newsArticleRemoteDatasource.getNewsArticle();
        if (articleList == []) {
          return Left(EmptyList('Sorry List is Empty.'));
        } else {
          return Right(articleList);
        }
      } catch (e) {
        throw UnknownFailure(e);
      }
    } else {
      return Left(NetworkDisconnected('No internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<NewsArticle?>>> getConcreteArticles(
      String category) async {
    if (await networkInfo.isConnected) {
      try {

        
        final article = await newsArticleConcreteDatasource
            .getNewsConcreteArticle(category);

        return Right(article);
      } on ServerException {
        throw Left(ServerFailure('Failed to load data from API'));
      }
    } else {
      return Left(NetworkDisconnected('No internet Connection'));
    }
  }
}
