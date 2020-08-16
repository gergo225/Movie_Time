import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';

import 'package:movie_time/data/home/media_list_model.dart';
import 'package:movie_time/domain/core/genre_utils.dart';

abstract class HomeInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/trending/movie/day?api_key=<<api_key>>
  ///
  /// Throws a [ServerException] for all error codes
  Future<MediaListModel> getTrendingMovies();

  /// Calls the https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres={genreId}
  ///
  /// Throws a [ServerException] for all error codes
  Future<MediaListModel> getMoviesByGenre(int genreId);

  /// Calls the https://api.themoviedb.org/3/trending/tv/day?api_key=<<api_key>>
  ///
  /// Throws a [ServerException] for all error codes
  Future<MediaListModel> getTrendingSeries();

  /// Calls the https://api.themoviedb.org/3/discover/tv?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres={genreId}
  ///
  /// Throws a [ServerException] for all error codes
  Future<MediaListModel> getSeriesByGenre(int genreId);
}

class HomeInfoRemoteDataSourceImpl implements HomeInfoRemoteDataSource {
  final http.Client client;

  HomeInfoRemoteDataSourceImpl({@required this.client});

  @override
  Future<MediaListModel> getMoviesByGenre(int genreId) {
    return _getMediaListFromUrl(
      "https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId",
      GenreUtil.genreIdAndName[genreId],
    );
  }

  @override
  Future<MediaListModel> getTrendingMovies() {
    return _getMediaListFromUrl(
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$API_KEY",
      "Trending",
    );
  }

  @override
  Future<MediaListModel> getSeriesByGenre(int genreId) {
    return _getMediaListFromUrl(
      "https://api.themoviedb.org/3/discover/tv?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId",
      GenreUtil.genreIdAndName[genreId],
    );
  }

  @override
  Future<MediaListModel> getTrendingSeries() {
    return _getMediaListFromUrl(
      "https://api.themoviedb.org/3/trending/tv/day?api_key=$API_KEY",
      "Trending",
    );
  }

  Future<MediaListModel> _getMediaListFromUrl(
      String url, String listName) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return MediaListModel.fromJson(json.decode(response.body), listName, 10);
    } else {
      throw ServerException();
    }
  }
}
