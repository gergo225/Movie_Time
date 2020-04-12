import 'package:meta/meta.dart';
import '../../domain/entities/search_result.dart';
import 'searched_movie_info_model.dart';

class SearchResultModel extends SearchResult {
  final List<SearchedMovieInfoModel> results;

  SearchResultModel({
    @required this.results,
  }) : super(results: results);

  factory SearchResultModel.from(Map<String, dynamic> json) {
    return SearchResultModel(
      results: List<SearchedMovieInfoModel>.from(
        json["results"].map(
            (searchMovieJson) => SearchedMovieInfoModel.from(searchMovieJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"results": results.map((searchedMovie) => searchedMovie.toJson())};
  }
}
