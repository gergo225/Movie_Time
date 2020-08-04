import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/series/series_info_remote_data_source.dart';
import 'package:movie_time/domain/series/series_info.dart';
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/series/series_info_repository.dart';

typedef Future _SeriesOrSeasonChooser();

class SeriesInfoRepositoryImpl implements SeriesInfoRepository {
  final NetworkInfo networkInfo;
  final SeriesInfoRemoteDataSource remoteDataSource;

  SeriesInfoRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, SeriesInfo>> getSeriesById(int id) async {
    return await _getInfo(() => remoteDataSource.getSeriesById(id));
  }

  @override
  Future<Either<Failure, SeasonInfo>> getSeriesSeasonByNumber(
    int seriesId,
    int seasonNumber,
  ) async {
    return await _getInfo(() => remoteDataSource.getSeriesSeasonByNumber(seriesId, seasonNumber));
  }

  Future<Either<Failure, T>> _getInfo<T>(
      _SeriesOrSeasonChooser getSeriesOrSeason) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteInfo = await getSeriesOrSeason();
        return Right(remoteInfo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
