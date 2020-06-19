part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List get props => [];
}

class Empty extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  final SearchResult searchResult;

  Loaded({@required this.searchResult});

  @override
  List get props => [searchResult];
}

class Error extends SearchState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
