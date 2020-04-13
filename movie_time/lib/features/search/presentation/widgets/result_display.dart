import 'package:flutter/material.dart';
import 'package:movie_time/features/movie/presentation/widgets/message_display.dart';
import 'searched_movie_item.dart';
import '../../domain/entities/search_result.dart';

const String NO_SEARCH_RESULTS_MESSAGE = "No results were found";

class ResultDisplay extends StatelessWidget {
  final SearchResult searchResult;

  const ResultDisplay({Key key, @required this.searchResult})
      : assert(searchResult != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchResult.results.length == 0) {
      return MessageDisplay(message: NO_SEARCH_RESULTS_MESSAGE);
    } else {
      return ListView.separated(
        itemCount: searchResult.results.length,
        itemBuilder: (_, index) => SearchedMovieItem(
          searchedMovieInfo: searchResult.results[index],
        ),
        separatorBuilder: (_, __) => Divider(),
      );
    }
  }
}
