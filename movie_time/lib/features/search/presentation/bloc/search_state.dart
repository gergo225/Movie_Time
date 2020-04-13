part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  final SearchResult searchResult;

  Loaded({@required this.searchResult}) : super([searchResult]);
}

class Error extends SearchState {
  final String message;

  Error({@required this.message}) : super([message]);
}
