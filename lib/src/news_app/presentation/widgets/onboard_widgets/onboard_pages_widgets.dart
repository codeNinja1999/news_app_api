// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OnBoardPageWidgets {
  buildPages(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
