import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/core/theme/app_theme/app_theme.dart';
import 'package:news_app_api/core/theme/bloc/theme_event.dart';
import 'package:news_app_api/core/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: appThemeData[AppTheme.light] ?? ThemeData.light())) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeState(themeData: appThemeData[event.theme]!), );
    });
  }
}
