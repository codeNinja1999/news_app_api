// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class NewsBlocEvent extends Equatable {}

class ShowFetchedData extends NewsBlocEvent {
  @override
  List<Object?> get props => [];
}

class SelectNewsCategoryEvent extends NewsBlocEvent {
  final String newsCategory;
  SelectNewsCategoryEvent({required this.newsCategory});

  @override
  List<Object?> get props => [newsCategory];
}
