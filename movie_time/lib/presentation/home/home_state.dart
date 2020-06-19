part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List get props => [];
}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final HomeInfo homeInfo;
  
  Loaded({@required this.homeInfo});

  @override
  List get props => [homeInfo];
}

class Error extends HomeState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
