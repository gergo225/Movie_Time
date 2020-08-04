part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetInfoForMovieById extends MovieInfoEvent {
  final int movieId;

  GetInfoForMovieById(this.movieId);

  @override
  List<Object> get props => [movieId];
}