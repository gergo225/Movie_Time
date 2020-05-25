import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/home/home_bloc.dart';
import 'package:movie_time/presentation/home/widgets/home_display.dart';

class HomeInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      body: buildBody(),
    );
  }

  BlocProvider<HomeBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(GetInfoForHome()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is Loaded) {
            return HomeDisplay(homeInfo: state.homeInfo);
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
