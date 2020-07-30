import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/actor/get_actor_by_id.dart';
import 'package:movie_time/domain/core/failure.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final GetActorById getActorById;

  ActorBloc({@required this.getActorById})
      : assert(getActorById != null),
        super(Loading());

  @override
  Stream<ActorState> mapEventToState(
    ActorEvent event,
  ) async* {
    if (event is GetInfoForActorById) {
      final failureOrActor = await getActorById(Params(id: event.actorId));
      yield failureOrActor.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (actor) => Loaded(actor: actor),
      );
    }
  }
}
