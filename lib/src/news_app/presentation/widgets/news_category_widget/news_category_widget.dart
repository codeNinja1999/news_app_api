// ignore_for_file: prefer_const_constructors

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/core/config/app_config.dart';
import 'package:news_app_api/core/config/helpers/news_category_helper.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';

class NewsCategoryWidget extends StatelessWidget {
  const NewsCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          BuildCategoryCard(
              imageUrl: 'assets/images/apple.jpg',
              categoryText: 'Apple',
              categoryUrl: NewsCategoryHelper().apple()),
          SizedBox(
            width: 10,
          ),
          BuildCategoryCard(
              imageUrl: 'assets/images/tesla.jpg',
              categoryText: 'Tesla',
              categoryUrl: NewsCategoryHelper().tesla()),
          SizedBox(
            width: 10,
          ),
          BuildCategoryCard(
              imageUrl: 'assets/images/us.jpg',
              categoryText: 'Us Headlines',
              categoryUrl: NewsCategoryHelper().usHeadline()),
          SizedBox(
            width: 10,
          ),
          BuildCategoryCard(
              imageUrl: 'assets/images/tech_crunch.jpg',
              categoryText: 'Tech Headlines',
              categoryUrl: NewsCategoryHelper().techCrunchHeadline()),
          SizedBox(
            width: 10,
          ),
          BuildCategoryCard(
              imageUrl: 'assets/images/wall_street.jpg',
              categoryText: 'Wall Street Headlines',
              categoryUrl: NewsCategoryHelper().wallStreetHeadline()),
        ],
      ),
    );
  }
}

class BuildCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryText;
  final String categoryUrl;

  const BuildCategoryCard(
      {super.key,
      required this.imageUrl,
      required this.categoryText,
      required this.categoryUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 120,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image:
                DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
          )),
          InkWell(
            onTap: () {
              context.read<NewsBlocBloc>().add(
                    SelectNewsCategoryEvent(newsCategory: categoryUrl),
                  );
              UrlPreferences.setNewsUrl(categoryUrl);  
            },
            child: Center(
              child: Text(
                categoryText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
