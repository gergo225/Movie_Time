import 'package:flutter/material.dart';
import 'package:movie_time/domain/search/searched_movie_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';

class SearchedMovieItem extends StatelessWidget {
  final SearchedMovieInfo searchedMovieInfo;

  const SearchedMovieItem({Key key, @required this.searchedMovieInfo})
      : assert(searchedMovieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemHeight = 128.0;
    final posterWidth = 2 / 3 * itemHeight;

    return InkWell(
      onTap: () => openMoviePage(searchedMovieInfo.id, context),
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
                imageUrl: searchedMovieInfo.posterPathUrl,
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
                    searchedMovieInfo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    searchedMovieInfo.releaseYearString,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      StarRating(
                          rating: searchedMovieInfo.rating, starSize: 20),
                      Text(
                        "${searchedMovieInfo.rating}",
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

  void openMoviePage(int movieId, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MovieInfoPage(movieId: movieId);
      },
    ));
  }
}
