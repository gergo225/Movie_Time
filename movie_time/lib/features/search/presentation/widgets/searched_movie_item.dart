import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/image_link_creator.dart';
import '../../domain/entities/searched_movie_info.dart';
import 'loading_widget.dart';

class SearchedMovieItem extends StatelessWidget {
  final SearchedMovieInfo searchedMovieInfo;

  const SearchedMovieItem({Key key, @required this.searchedMovieInfo})
      : assert(searchedMovieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        height: 76,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
              imageUrl: createImageLink(searchedMovieInfo.posterPath),
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) =>
                  Placeholder(fallbackWidth: 64,strokeWidth: 1,),
              fit: BoxFit.contain,
              width: 64,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchedMovieInfo.title,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.visible,
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
}
