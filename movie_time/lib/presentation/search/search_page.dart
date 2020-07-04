import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'widgets/widgets.dart';
import 'search_bloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                // Search bar
                SearchInput(),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is Empty) {
                          return MessageDisplay(message: "Start searching!");
                        } else if (state is Loading) {
                          return LoadingWidget();
                        } else if (state is Loaded) {
                          return ResultDisplay(
                              searchResult: state.searchResult);
                        } else if (state is Error) {
                          return MessageDisplay(message: state.message);
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
