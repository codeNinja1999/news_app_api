import 'package:equatable/equatable.dart';
import 'package:flutter/Material.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}
