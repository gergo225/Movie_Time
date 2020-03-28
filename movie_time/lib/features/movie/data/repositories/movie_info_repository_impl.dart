import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movie_time/core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/movie_info.dart';
import '../../domain/repositories/movie_info_repository.dart';
import '../datasources/movie_info_remote_data_source.dart';

class MovieInfoRepositoryImpl implements MovieInfoRepository {
  final MovieInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> getLatestMovieId() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovieId = await remoteDataSource.getLatestMovieId();
        return Right(remoteMovieId);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

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
