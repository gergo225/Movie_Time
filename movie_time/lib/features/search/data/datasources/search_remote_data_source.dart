import 'package:movie_time/features/search/data/models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&query={title}&page=1
  /// 
  /// Throws a [ServerException] for all error codes
  Future<SearchResultModel> searchMovieByTitle(String title); 
}