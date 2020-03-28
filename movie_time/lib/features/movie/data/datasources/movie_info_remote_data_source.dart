import '../models/movie_info_model.dart';

abstract class MovieInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/movie/{id}?api_key=<<api_key>> TODO: get api key
  /// 
  /// Throws a [ServerException] for all error codes
  Future<MovieInfoModel> getMovieById(int id);

  /// Calls the https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>> TODO: get api key
  /// 
  /// Throws a [ServerException] for all error codes
  Future<int> getLatestMovieId();
}