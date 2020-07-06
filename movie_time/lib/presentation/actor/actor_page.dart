import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/actor/actor_bloc.dart';
import 'package:movie_time/presentation/actor/widgets/actor_display.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';

class ActorPage extends StatelessWidget {
  final int actorId;

  ActorPage({@required this.actorId}) : assert(actorId != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<ActorBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ActorBloc>()..add(GetInfoForActorById(actorId)),
      child: BlocBuilder<ActorBloc, ActorState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Loaded) {
            return ActorDisplay(actorInfo: state.actor);
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
