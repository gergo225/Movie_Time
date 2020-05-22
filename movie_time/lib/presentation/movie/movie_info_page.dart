import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/widgets/movie_display/movie_display.dart';
import 'movie_info_bloc.dart';

class MovieInfoPage extends StatelessWidget {
  final int movieId;

  MovieInfoPage({@required this.movieId}) : assert(movieId != null);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); // Go fullscreen

    return Scaffold(
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  BlocProvider<MovieInfoBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieInfoBloc>()..add(GetInfoForMovieById(movieId)),
      child: BlocBuilder<MovieInfoBloc, MovieInfoState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Loaded) {
            return MovieDisplay(movieInfo: state.movie);
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
