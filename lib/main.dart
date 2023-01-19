// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/core/config/app_config.dart';
import 'package:news_app_api/core/setting/setting_preferences.dart';
import 'package:news_app_api/core/theme/bloc/bloc.dart';
import 'package:news_app_api/core/theme/preference/preferences.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/bloc/news_bloc.dart';
import 'package:news_app_api/src/news_app/presentation/pages/home_page/home_page.dart';
import 'package:news_app_api/src/news_app/presentation/pages/onboarding_page/onboarding_screen.dart';

import 'dependency_injection.dart' as di;
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Preferences.init();
  await SettingPreferences.init();
  await UrlPreferences.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NewsBlocBloc>(
          create: (BuildContext context) => sl<NewsBlocBloc>(),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => sl<ThemeBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          home:
              SettingPreferences.getHomeKey() ? HomePage() : OnBoardingScreen(),
        );
      },
    );
  }
}
