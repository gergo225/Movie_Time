part of 'series_bloc.dart';

@immutable
abstract class SeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Loading extends SeriesState {}

class SeriesLoaded extends SeriesState {
  final SeriesInfo series;

  SeriesLoaded({@required this.series});

  @override
  List<Object> get props => [series];
}

class SeasonLoaded extends SeriesState {
  final SeasonInfo season;

  SeasonLoaded({@required this.season});

  @override
  List<Object> get props => [season];
}

class Error extends SeriesState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
