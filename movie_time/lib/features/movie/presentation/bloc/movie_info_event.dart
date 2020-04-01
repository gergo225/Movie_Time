part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieById extends MovieInfoEvent {
  final idString;

  GetMovieById(this.idString);

  @override
  List<Object> get props => [idString];
}

class GetLatestMovie extends MovieInfoEvent {}
