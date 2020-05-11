import 'package:flutter/material.dart';
import 'package:movie_time/domain/search/searched_movie_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';

class SearchedMovieItem extends StatelessWidget {
  final SearchedMovieInfo searchedMovieInfo;

  const SearchedMovieItem({Key key, @required this.searchedMovieInfo})
      : assert(searchedMovieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openMoviePage(searchedMovieInfo.id, context),
      child: Container(
        width: double.infinity,
        height: 76,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            PlatformIndependentImage(
              imageUrl: searchedMovieInfo.posterPathUrl,
              errorWidget: NoImageWidget.poster(),
              loadingWidget: LoadingWidget(),
              width: 64,
              boxFit: BoxFit.contain,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchedMovieInfo.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: <Widget>[
                      Text(
                        searchedMovieInfo.releaseYear.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Spacer(),
                      Text(
                        searchedMovieInfo.rating.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
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
