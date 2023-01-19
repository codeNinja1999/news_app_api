import 'package:equatable/equatable.dart';
import 'package:news_app_api/core/theme/app_theme/app_theme.dart';

abstract class ThemeEvent extends Equatable {}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({required this.theme});

  @override
  List<Object?> get props => [theme];
}
