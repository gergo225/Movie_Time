import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'searched_media_info.dart';

class SearchResult extends Equatable {
  final List<SearchedMediaInfo> movies;
  final List<SearchedMediaInfo> series;

  SearchResult({
    @required this.movies,
    @required this.series,
  });

  @override
  List get props => [movies, series];
}
