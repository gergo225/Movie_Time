import 'package:flutter/material.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/search/searched_media_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';
import 'package:movie_time/presentation/series/series_info_page.dart';

class SearchedMediaItem extends StatelessWidget {
  final SearchedMediaInfo searchedMediaInfo;

  const SearchedMediaItem({Key key, @required this.searchedMediaInfo})
      : assert(searchedMediaInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemHeight = 128.0;
    final posterWidth = 2 / 3 * itemHeight;

    return InkWell(
      onTap: () => openMediaPage(
        context,
        searchedMediaInfo.id,
        searchedMediaInfo.mediaType,
      ),
      child: Container(
        height: itemHeight,
        decoration: BoxDecoration(
          color: AppColors.searchedMovieBackground,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: PlatformIndependentImage(
                imageUrl: searchedMediaInfo.posterPathUrl,
                errorWidget: NoImageWidget.poster(),
                loadingWidget: LoadingWidget(),
                width: posterWidth,
                boxFit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchedMediaInfo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.searchedMovieItemTitle,
                  ),
                  SizedBox(height: 2),
                  Text(
                    searchedMediaInfo.releaseYearString,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      StarRating(
                          rating: searchedMediaInfo.rating, starSize: 20),
                      Text(
                        "${searchedMediaInfo.rating}",
                        style: TextStyle(
                          color: AppColors.searchedMovieRating,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openMediaPage(BuildContext context, int mediaId, MediaType mediaType) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return mediaType == MediaType.movie
            ? MovieInfoPage(movieId: mediaId)
            : SeriesInfoPage(seriesId: mediaId);
      },
    ));
  }
}
