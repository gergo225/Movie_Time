import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/widgets/movie_display.dart';
import 'movie_info_bloc.dart';

class MovieInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  BlocProvider<MovieInfoBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieInfoBloc>(),
      child: BlocBuilder<MovieInfoBloc, MovieInfoState>(
        builder: (context, state) {
          BlocProvider.of<MovieInfoBloc>(context).add(GetInfoForMovieById(
              429617)); // TODO: remove after page is finished
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Loaded) {
            // TODO: Add Loaded page
            return MovieDisplay(movieInfo: state.movie,);
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          }
          return null;
        },
      ),
    );
  }
}
