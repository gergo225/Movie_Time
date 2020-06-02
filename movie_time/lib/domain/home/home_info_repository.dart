import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/home/movie_list.dart';

abstract class HomeInfoRepository {
  Future<Either<Failure, MovieList>> getTrendingMovies();
  Future<Either<Failure, MovieList>> getMoviesByGenre(int genreId);
}