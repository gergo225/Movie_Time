import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/series/series_info_repository.dart';

class GetSeriesSeasonByNumber extends UseCase<SeasonInfo, Params> {
  final SeriesInfoRepository repository;

  GetSeriesSeasonByNumber(this.repository);

  @override
  Future<Either<Failure, SeasonInfo>> call(Params params) async {
    return await repository.getSeriesSeasonByNumber(
      params.seriesId,
      params.seasonNumber,
    );
  }
}

class Params extends Equatable {
  final int seriesId;
  final int seasonNumber;

  Params({
    @required this.seriesId,
    @required this.seasonNumber,
  });

  @override
  List<Object> get props => [seriesId, seasonNumber];
}
