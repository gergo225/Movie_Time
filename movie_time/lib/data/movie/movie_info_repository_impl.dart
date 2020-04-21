import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/domain/core/failure.dart';

import 'package:movie_time/domain/movie/movie_info_repository.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'movie_info_remote_data_source.dart';

class MovieInfoRepositoryImpl implements MovieInfoRepository {
  final MovieInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MovieInfo>> getMovieById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await remoteDataSource.getMovieById(id);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
