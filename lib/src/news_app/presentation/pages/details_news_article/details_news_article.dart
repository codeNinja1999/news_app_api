// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import 'package:news_app_api/src/news_app/domain/entity/news_article.dart';

class DetailsNewsArticle extends StatelessWidget {
  final NewsArticle article;
  const DetailsNewsArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source == null
            ? article.url.toString()
            : article.author.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    article.urlToImage ??
                        'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png',
                    errorListener: () =>
                        Image.asset('assets/images/no_image_icon.png'),
                  ),
                  onError: (exception, stackTrace) {
                    if (exception.runtimeType == exception) {
                      Text('Failed to load image');
                    }

                    Text(stackTrace.toString());
                  },
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              // child: CachedNetworkImage(
              //   imageUrl: article.urlToImage ??
              //       'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png',
              //   placeholder: (context, url) =>
              //       Center(child: CircularProgressIndicator()),
              //   errorWidget: (context, url, error) =>
              //       Image.asset('assets/images/image_5.jpg'),
              // ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(article.title.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(article.description.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Content: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(article.content.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Published At:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(article.publishedAt.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
