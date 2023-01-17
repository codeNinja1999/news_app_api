import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_api/core/network/network_info.dart';
import 'package:news_app_api/src/news_app/data/data_source/news_article_concrete_datasource.dart';
import 'package:news_app_api/src/news_app/data/data_source/news_article_remote_datasource.dart';
import 'package:news_app_api/src/news_app/data/repositories/news_article_repository_impl.dart';
import 'package:news_app_api/src/news_app/domain/repositories/news_article_repository.dart';
import 'package:news_app_api/src/news_app/domain/usecases/get_concrete_news_article.dart';
import 'package:news_app_api/src/news_app/domain/usecases/get_news_article.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

void init() async {
  sl.registerFactory(
    () => NewsBlocBloc(getNewsArticle: sl(), getNewsConcreteArticle: sl()),
  );

  //usecases
  sl.registerLazySingleton(
    () => GetNewsArticle(sl()),
  );
  sl.registerLazySingleton(
    () => GetNewsConcreteArticle(sl()),
  );

  //repository
  sl.registerLazySingleton<NewsArticleRepository>(
    () => NewsArticleRepositoryImpl(
      networkInfo: sl(),
      newsArticleRemoteDatasource: sl(),
      newsArticleConcreteDatasource: sl(),
    ),
  );

  //datasource
  sl.registerLazySingleton<NewsArticleRemoteDatasource>(
      () => NewsArticleRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<NewsArticleConcreteDatasource>(
      () => NewsArticleConcreteDatasourceImpl(client: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
