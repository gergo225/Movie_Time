import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_movie_info.dart';

class SearchResult extends Equatable {
  final List<SearchMovieInfo> results;

  SearchResult({@required this.results}) : super([results]);
}
