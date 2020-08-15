import 'package:flutter/material.dart';
import 'package:movie_time/domain/search/search_result.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'searched_media_item.dart';

class ResultDisplay extends StatelessWidget {
  final SearchResult searchResult;

  const ResultDisplay({Key key, @required this.searchResult})
      : assert(searchResult != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchResult.movies.length + searchResult.series.length == 0) {
      return MessageDisplay(message: AppStrings.noResults);
    } else {
      return ListView(
        children: [
          Text(
            AppStrings.movies,
            style: AppTextStyles.subtitle,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: searchResult.movies.length,
            itemBuilder: (_, index) => SearchedMediaItem(
              searchedMediaInfo: searchResult.movies[index],
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8),
          ),
          SizedBox(height: 16),
          Text(
            AppStrings.series,
            style: AppTextStyles.subtitle,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: searchResult.series.length,
            itemBuilder: (_, index) => SearchedMediaItem(
              searchedMediaInfo: searchResult.series[index],
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8),
          ),
        ],
      );
    }
  }
}
