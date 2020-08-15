import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/search/search_result.dart';
import 'searched_media_info_model.dart';

class SearchResultModel extends SearchResult {
  final List<SearchedMediaInfoModel> movies;
  final List<SearchedMediaInfoModel> series;

  SearchResultModel({
    @required this.movies,
    @required this.series,
  }) : super(movies: movies, series: series);

  factory SearchResultModel.from(Map<String, dynamic> json) {
    final movieJsons = json["results"]
        .where((resultJson) => resultJson["media_type"] == "movie");
    final seriesJsons =
        json["results"].where((resultJson) => resultJson["media_type"] == "tv");

    return SearchResultModel(
      movies: List<SearchedMediaInfoModel>.from(
        movieJsons
            .where((movieJson) =>
                movieJson["video"] == false && movieJson["vote_count"] > 0)
            .map((searchMovieJson) =>
                SearchedMediaInfoModel.from(searchMovieJson)),
      ),
      series: List<SearchedMediaInfoModel>.from(
        seriesJsons.where((seriesJson) => seriesJson["vote_count"] > 0 as bool).map(
            (searchSeriesJson) =>
                SearchedMediaInfoModel.from(searchSeriesJson)),
      ),
    );
  }
}
