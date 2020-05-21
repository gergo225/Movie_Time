import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/movie_list.dart';

typedef Future<MovieList<T>> _TrendingOrGenreChooser<T>();

class HomeInfoRepositoryImpl implements HomeInfoRepository {
  final NetworkInfo networkInfo;
  final HomeInfoRemoteDataSource remoteDataSource;

  HomeInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MovieList<ShortMovieInfo>>> getMoviesByGenre(
      int genreId) async {
    return await _getMovieList<ShortMovieInfo>(() {
      return remoteDataSource.getMoviesByGenre(genreId);
    });
  }

  @override
  Future<Either<Failure, MovieList<TrendingMovieInfo>>> getTrendingMovies() async {
    return await _getMovieList<TrendingMovieInfo>(() {
      return remoteDataSource.getTrendingMovies();
    });
  }

  Future<Either<Failure, MovieList<T>>> _getMovieList<T>(
      _TrendingOrGenreChooser getTrendingOrGenre) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovieList = await getTrendingOrGenre();
        return Right(remoteMovieList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
