// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatelessWidget {
  final PageController pageController;

  const PageIndicatorWidget({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              pageController.animateToPage(3,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              'SKIP',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            onDotClicked: (index) => pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn),
            //effect: ScrollingDotsEffect(dotHeight: 8),
          ),
          TextButton(
            onPressed: () {
              pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              'NEXT',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
