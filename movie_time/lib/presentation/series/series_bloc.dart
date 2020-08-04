import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/series/get_series_by_id.dart' as series;
import 'package:movie_time/domain/series/get_series_season_by_number.dart'
    as season;
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/series/series_info.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final series.GetSeriesById getSeriesById;
  final season.GetSeriesSeasonByNumber getSeriesSeasonByNumber;

  SeriesBloc({
    @required series.GetSeriesById seriesById,
    @required season.GetSeriesSeasonByNumber seasonByNumber,
  })  : assert(seriesById != null),
        assert(seasonByNumber != null),
        getSeriesById = seriesById,
        getSeriesSeasonByNumber = seasonByNumber,
        super(Loading());

  @override
  Stream<SeriesState> mapEventToState(
    SeriesEvent event,
  ) async* {
    if (event is GetInfoForSeriesById) {
      final failureOrSeries =
          await getSeriesById(series.Params(id: event.seriesId));
      yield failureOrSeries.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (series) => SeriesLoaded(series: series),
      );
    } else if (event is GetInfoForSeasonByNumber) {
      final failureOrSeason = await getSeriesSeasonByNumber(season.Params(
        seriesId: event.seriesId,
        seasonNumber: event.seasonNumber,
      ));
      yield failureOrSeason.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (season) => SeasonLoaded(season: season),
      );
    }
  }
}
