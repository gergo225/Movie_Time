import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/media_list.dart';

typedef Future<MediaList> _TrendingOrGenreChooser();

class HomeInfoRepositoryImpl implements HomeInfoRepository {
  final NetworkInfo networkInfo;
  final HomeInfoRemoteDataSource remoteDataSource;

  HomeInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MediaList>> getMoviesByGenre(int genreId) async {
    return await _getMediaList(() {
      return remoteDataSource.getMoviesByGenre(genreId);
    });
  }

  @override
  Future<Either<Failure, MediaList>> getTrendingMovies() async {
    return await _getMediaList(() {
      return remoteDataSource.getTrendingMovies();
    });
  }

  @override
  Future<Either<Failure, MediaList>> getSeriesByGenre(int genreId) async {
    return await _getMediaList(() {
      return remoteDataSource.getSeriesByGenre(genreId);
    });
  }

  @override
  Future<Either<Failure, MediaList>> getTrendingSeries() async {
    return await _getMediaList(() {
      return remoteDataSource.getTrendingSeries();
    });
  }

  Future<Either<Failure, MediaList>> _getMediaList(
      _TrendingOrGenreChooser getTrendingOrGenre) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMediaList = await getTrendingOrGenre();
        return Right(remoteMediaList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
