import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';

import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/domain/core/genre_utils.dart';

abstract class HomeInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/trending/movie/day?api_key=<<api_key>>
  ///
  /// Throws a [ServerException] for all error codes
  Future<MovieListModel> getTrendingMovies();

  /// Calls the https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres={genreId}
  ///
  /// Throws a [ServerException] for all error codes
  Future<MovieListModel> getMoviesByGenre(int genreId);
}

class HomeInfoRemoteDataSourceImpl implements HomeInfoRemoteDataSource {
  final http.Client client;

  HomeInfoRemoteDataSourceImpl({@required this.client});

  @override
  Future<MovieListModel> getMoviesByGenre(int genreId) {
    return _getMovieListFromUrl(
      "https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId",
      GenreUtil.genreIdAndName[genreId],
    );
  }

  @override
  Future<MovieListModel> getTrendingMovies() {
    return _getMovieListFromUrl(
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$API_KEY",
      "Trending",
    );
  }

  Future<MovieListModel> _getMovieListFromUrl(
      String url, String listName) async {
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
      },
    );

    if (response.statusCode == 200) {
      return MovieListModel.fromJson(
          json.decode(response.body), listName, 10);
    } else {
      throw ServerException();
    }
  }
}
