import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/series/series_bloc.dart';
import 'package:movie_time/presentation/series/widgets/series_display.dart';

class SeriesInfoPage extends StatelessWidget {
  final int seriesId;

  const SeriesInfoPage({@required this.seriesId}) : assert(seriesId != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }
  
  BlocProvider<SeriesBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SeriesBloc>()..add(GetInfoForSeriesById(seriesId)),
      child: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          } else if (state is SeriesLoaded) {
            return SeriesDisplay(seriesInfo: state.series);
          }
          return Container();
        },
      ),
    );
  }
}
