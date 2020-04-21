import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'movie_info_bloc.dart';

class MovieInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Info"),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<MovieInfoBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieInfoBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              // Top half
              BlocBuilder<MovieInfoBloc, MovieInfoState>(
                builder: (context, state) {
                  // TODO: display pages for the states
                  if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
