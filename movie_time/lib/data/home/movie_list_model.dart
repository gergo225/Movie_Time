import 'package:flutter/foundation.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:movie_time/domain/home/movie_list.dart';

class MovieListModel extends MovieList {
  final String listName;
  final List<ShortMovieInfoModel> movieList;

  MovieListModel({
    @required this.listName,
    @required this.movieList,
  }) : super(listName: listName, movieList: movieList);

  factory MovieListModel.fromJson(
      Map<String, dynamic> json, String listName, int length) {
    return MovieListModel(
      listName: listName,
      movieList: List<ShortMovieInfoModel>.from(
        json["results"].take(length).map((movieJson) {
          return ShortMovieInfoModel.fromJson(movieJson);
        }),
      ),
    );
  }
}
