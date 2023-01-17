// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/core/theme_config/app_theme.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/home_page.dart';
import 'package:news_app_api/src/news_app/presentation/pages/onboarding_page/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection.dart' as di;
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  final pref = await SharedPreferences.getInstance();
  final showHome = pref.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.showHome});

  final bool showHome;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsBlocBloc>(),
      child: MaterialApp(
      
        debugShowCheckedModeBanner: false,
        home: widget.showHome ? HomePage() : OnBoardingScreen(),
      ),
    );
  }
}
