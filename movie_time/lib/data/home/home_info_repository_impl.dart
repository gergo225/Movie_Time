import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/movie_list.dart';

typedef Future<MovieList> _TrendingOrGenreChooser();

class HomeInfoRepositoryImpl implements HomeInfoRepository {
  final NetworkInfo networkInfo;
  final HomeInfoRemoteDataSource remoteDataSource;

  HomeInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MovieList>> getMoviesByGenre(
      int genreId) async {
    return await _getMovieList(() {
      return remoteDataSource.getMoviesByGenre(genreId);
    });
  }

  @override
  Future<Either<Failure, MovieList>> getTrendingMovies() async {
    return await _getMovieList(() {
      return remoteDataSource.getTrendingMovies();
    });
  }

  Future<Either<Failure, MovieList>> _getMovieList(
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
