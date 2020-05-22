part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final HomeInfo homeInfo;
  
  Loaded({@required this.homeInfo}) : super([homeInfo]);
}

class Error extends HomeState {
  final String message;

  Error({@required this.message}) : super([message]);
}
