import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'movie_info.dart';

abstract class MovieInfoRepository {
  Future<Either<Failure, MovieInfo>> getMovieById(int id);
}