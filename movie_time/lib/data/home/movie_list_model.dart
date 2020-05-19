import 'package:flutter/foundation.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:movie_time/data/home/trending_movie_info_model.dart';
import 'package:movie_time/domain/home/movie_list.dart';

class MovieListModel<T> extends MovieList<T> {
  final String listName;
  final List<T> movieList;

  MovieListModel({
    @required this.listName,
    @required this.movieList,
  }) : super(listName: listName, movieList: movieList);

  factory MovieListModel.fromJson(
      Map<String, dynamic> json, String listName, int length) {
    return MovieListModel(
      listName: listName,
      movieList: List<T>.from(
        json["results"].take(length).map((movieJson) {
          if (T == ShortMovieInfoModel) {
            return ShortMovieInfoModel.fromJson(movieJson);
          } else if (T == TrendingMovieInfoModel)
            return TrendingMovieInfoModel.fromJson(movieJson);
          else {
            throw TypeError();
          }
        }),
      ),
    );
  }
}
