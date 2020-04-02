part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInfoForMovieById extends MovieInfoEvent {
  final idString;

  GetInfoForMovieById(this.idString);

  @override
  List<Object> get props => [idString];
}

class GetInfoForLatestMovie extends MovieInfoEvent {}
