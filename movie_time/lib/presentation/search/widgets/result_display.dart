import 'package:flutter/material.dart';
import 'package:movie_time/domain/search/search_result.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'searched_movie_item.dart';

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
        padding: EdgeInsets.zero,
        itemCount: searchResult.results.length,
        itemBuilder: (_, index) => SearchedMovieItem(
          searchedMovieInfo: searchResult.results[index],
        ),
        separatorBuilder: (_, __) => SizedBox(height: 8),
      );
    }
  }
}
