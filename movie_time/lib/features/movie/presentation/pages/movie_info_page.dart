import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_info_bloc.dart';
import '../../../../injection_container.dart';
import '../widgets/widgets.dart';

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
                  if (state is Empty) {
                    return MessageDisplay(message: "Start searching!");
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return InfoDisplay(movieInfo: state.movie);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              InfoControls()
            ],
          ),
        ),
      ),
    );
  }
}
