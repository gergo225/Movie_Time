import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movie_time/core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie_info.dart';
import '../../domain/repositories/movie_info_repository.dart';
import '../datasources/movie_info_remote_data_source.dart';

typedef Future<MovieInfo> _ByIdOrLatestChooser();

class MovieInfoRepositoryImpl implements MovieInfoRepository {
  final MovieInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MovieInfo>> getMovieById(int id) async {
    return await _getMovie(() {
      return remoteDataSource.getMovieById(id);
    });
  }

  @override
  Future<Either<Failure, MovieInfo>> getLatestMovie() async {
    return await _getMovie(() {
      return remoteDataSource.getLatestMovie();
    });
  }

  Future<Either<Failure, MovieInfo>> _getMovie(
    _ByIdOrLatestChooser getByIdOrLatest,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await getByIdOrLatest();
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
