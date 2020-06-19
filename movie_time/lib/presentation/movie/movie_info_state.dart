part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoState extends Equatable {
  @override
  List get props => [];
}

class Loading extends MovieInfoState {}

class Loaded extends MovieInfoState {
  final MovieInfo movie;

  Loaded({@required this.movie});

  @override
  List get props => [movie];
}

class Error extends MovieInfoState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
