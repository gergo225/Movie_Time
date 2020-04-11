import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../../../core/util/api_key.dart';
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

class MovieInfoRemoteDataSourceImpl implements MovieInfoRemoteDataSource {
  final http.Client client;

  MovieInfoRemoteDataSourceImpl({@required this.client});

  @override
  Future<MovieInfoModel> getMovieById(int id) => _getMovieFromUrl(
      "https://api.themoviedb.org/3/movie/$id?api_key=$API_KEY");

  @override
  Future<MovieInfoModel> getLatestMovie() => _getMovieFromUrl(
      "https://api.themoviedb.org/3/movie/latest?api_key=$API_KEY");

  Future<MovieInfoModel> _getMovieFromUrl(String url) async {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return MovieInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
