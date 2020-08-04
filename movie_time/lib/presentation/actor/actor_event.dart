part of 'actor_bloc.dart';

@immutable
abstract class ActorEvent extends Equatable {
  @override
  List get props => [];
}

class GetInfoForActorById extends ActorEvent {
  final int actorId;

  GetInfoForActorById(this.actorId);

  @override
  List get props => [actorId];
}
