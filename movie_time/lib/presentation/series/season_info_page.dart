import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/series/series_bloc.dart';
import 'package:movie_time/presentation/series/widgets/season_display.dart';

class SeasonInfoPage extends StatelessWidget {
  final int seriesId;
  final int seasonNumber;

  SeasonInfoPage({
    @required this.seriesId,
    @required this.seasonNumber,
  })  : assert(seriesId != null),
        assert(seasonNumber != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<SeriesBloc> buildBody(BuildContext context) {
    return BlocProvider<SeriesBloc>(
      create: (_) => sl<SeriesBloc>()
        ..add(GetInfoForSeasonByNumber(seriesId, seasonNumber)),
      child: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          } else if (state is SeasonLoaded) {
            return SeasonDisplay(seasonInfo: state.season);
          }
          return Container();
        },
      ),
    );
  }
}
