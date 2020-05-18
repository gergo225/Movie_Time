import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

abstract class HomeInfoRepository {
  Future<Either<Failure, MovieList<TrendingMovieInfo>>> getTrendingMovies();
  Future<Either<Failure, MovieList<ShortMovieInfo>>> getMoviesByGenre(int genreId);
}