part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSearchesForTitle extends SearchEvent {
  final String movieTitle;

  GetSearchesForTitle(this.movieTitle);

  @override
  List<Object> get props => [movieTitle];
}