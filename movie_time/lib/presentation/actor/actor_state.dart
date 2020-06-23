part of 'actor_bloc.dart';

@immutable
abstract class ActorState extends Equatable {
  @override
  List get props => [];
}

class Loading extends ActorState {}

class Loaded extends ActorState {
  final ActorInfo actor;

  Loaded({@required this.actor});

  @override
  List get props => [actor];
}

class Error extends ActorState {
  final String message;

  Error({@required this.message});

  @override
  List get props => [message];
}
