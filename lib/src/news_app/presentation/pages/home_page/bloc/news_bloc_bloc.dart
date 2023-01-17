import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/core/usecase/usecase.dart';
import 'package:news_app_api/src/news_app/domain/usecases/get_concrete_news_article.dart';
import 'package:news_app_api/src/news_app/domain/usecases/get_news_article.dart';

import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';

class NewsBlocBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  GetNewsArticle getNewsArticle;
  GetNewsConcreteArticle getNewsConcreteArticle;

  NewsBlocBloc(
      {required this.getNewsArticle, required this.getNewsConcreteArticle})
      : super(NewsBlocInitial()) {
    on<ShowFetchedData>((event, emit) async {
      emit(Loading());
      final failureOrNews = await getNewsArticle(NoParams());
      failureOrNews.fold((failure) => emit(Error(message: failure.toString())),
          (news) => emit(Loaded(newsArticle: news)));
    });

    on<SelectNewsCategoryEvent>((event, emit) async {
      final category = event.newsCategory;
      emit(Loading());
      final failureOrNews =
          await getNewsConcreteArticle(Params(category: category));
      failureOrNews.fold((failure) => emit(Error(message: failure.toString())),
          (news) => emit(Loaded(newsArticle: news)));
    });
  }
}
