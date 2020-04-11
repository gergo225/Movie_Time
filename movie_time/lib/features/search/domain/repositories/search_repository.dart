import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResult>> searchMovieByTitle(String title);
}