// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:news_app_api/core/config/helpers/news_category_helper.dart';
import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';
import 'package:news_app_api/src/news_app/presentation/pages/details_news_article/details_news_article.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';
import 'package:news_app_api/src/news_app/presentation/pages/onboarding_page/onboarding_screen.dart';
import 'package:news_app_api/src/news_app/presentation/widgets/news_category_widget/news_category_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Center(
      child: CircularProgressIndicator(),
    );
    context.read<NewsBlocBloc>().add(ShowFetchedData());

    super.initState();
  }

  void clearcache() {
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool('showHome', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnBoardingScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        title: Text(
          'News App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            NewsCategoryWidget(),
            SizedBox(height: 10),
            Container(
              child: BlocBuilder<NewsBlocBloc, NewsBlocState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Loaded) {
                    List<NewsArticle?> articles = state.newsArticle;

                    return Expanded(
                      child: RefreshIndicator(
                          child: BuildNews(
                            articles: articles,
                          ),
                          onRefresh: () async {
                            clearcache();
                            final pref = await SharedPreferences.getInstance();
                            final String? category = pref.getString('category');

                            context.read<NewsBlocBloc>().add(
                                SelectNewsCategoryEvent(
                                    newsCategory: category ??
                                        NewsCategoryHelper().apple()));
                          }),
                    );
                  } else if (state is Error) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text('No state is loaded'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildNews extends StatelessWidget {
  BuildNews({super.key, required this.articles});

  final List<NewsArticle?> articles;

  final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(hours: 1),
      maxNrOfCacheObjects: 20,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          if (articles[index] != null) {
            NewsArticle article = articles[index] as NewsArticle;

            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsNewsArticle(
                    article: article,
                  ),
                ),
              ),
              child: ListTile(
                leading: CachedNetworkImage(
                  cacheManager: customCacheManager,
                  key: UniqueKey(),
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage ??
                      'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png',
                  placeholder: (context, url) =>
                      Image.asset('assets/images/no_image_icon.png'),
                  errorWidget: (context, url, error) => Text(
                    'Image failed to load',
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text(article.title.toString()),
                subtitle: Text(article.content.toString()),
              ),
            );
          }
          return Center(
            child: Text('No article found'),
          );
        });
  }
}