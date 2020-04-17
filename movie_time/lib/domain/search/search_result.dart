import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'searched_movie_info.dart';

class SearchResult extends Equatable {
  final List<SearchedMovieInfo> results;

  SearchResult({@required this.results}) : super([results]);
}
