import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/movie_info.dart';

abstract class MovieInfoRepository {
  Future<Either<Failure, MovieInfo>> getMovieById(int id);
  Future<Either<Failure, MovieInfo>> getLatestMovie();
}