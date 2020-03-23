import 'package:dartz/dartz.dart';
import 'package:movie_time/core/error/failures.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';

abstract class MovieInfoRepository {
  Future<Either<Failure, MovieInfo>> getMovieById(int id);
  Future<Either<Failure, int>> getLatestMovieId();
}