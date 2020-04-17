import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResult>> searchMovieByTitle(String title);
}