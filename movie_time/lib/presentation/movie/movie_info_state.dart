part of 'movie_info_bloc.dart';

@immutable
abstract class MovieInfoState extends Equatable {
  MovieInfoState([List props = const <dynamic>[]]) : super(props);
}

class Loading extends MovieInfoState {}

class Loaded extends MovieInfoState {
  final MovieInfo movie;

  Loaded({@required this.movie}) : super([movie]);
}

class Error extends MovieInfoState {
  final String message;

  Error({@required this.message}) : super([message]);
}
