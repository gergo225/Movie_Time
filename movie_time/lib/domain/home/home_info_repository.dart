import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/home/media_list.dart';

abstract class HomeInfoRepository {
  Future<Either<Failure, MediaList>> getTrendingMovies();
  Future<Either<Failure, MediaList>> getMoviesByGenre(int genreId);
  Future<Either<Failure, MediaList>> getTrendingSeries();
  Future<Either<Failure, MediaList>> getSeriesByGenre(int genreId);
}