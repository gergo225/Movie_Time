import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../../../core/error/exception.dart';

import '../models/movie_info_model.dart';

abstract class MovieInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/movie/{id}?api_key=<<api_key>> TODO: get api key
  ///
  /// Throws a [ServerException] for all error codes
  Future<MovieInfoModel> getMovieById(int id);

  /// Calls the https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>> TODO: get api key
  ///
  /// Throws a [ServerException] for all error codes
  Future<MovieInfoModel> getLatestMovie();
}
