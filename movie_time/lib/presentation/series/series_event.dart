part of 'series_bloc.dart';

@immutable
abstract class SeriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInfoForSeriesById extends SeriesEvent {
  final int seriesId;

  GetInfoForSeriesById(this.seriesId);

  @override
  List<Object> get props => [seriesId];
}

class GetInfoForSeasonByNumber extends SeriesEvent {
  final int seriesId;
  final int seasonNumber;

  GetInfoForSeasonByNumber(this.seriesId, this.seasonNumber);

  @override
  List<Object> get props => [seriesId, seasonNumber];
}
