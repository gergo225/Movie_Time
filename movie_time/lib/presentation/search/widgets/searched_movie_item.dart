import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/domain/search/searched_movie_info.dart';
import 'package:movie_time/presentation/core/widgets/loading_widget.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

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
            _imageOnWebOrOther(),
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

  Widget _imageOnWebOrOther() {
    Widget placeholder = Placeholder(
      fallbackWidth: 64,
      strokeWidth: 1,
    );

    if (kIsWeb) {
      if (searchedMovieInfo.posterPath == null) {
        return placeholder;
      } else {
        return Image.network(
          searchedMovieInfo.posterPathUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: LoadingWidget(),
            );
          },
          fit: BoxFit.contain,
          width: 64,
        );
      }
    } else {
      return CachedNetworkImage(
        imageUrl: searchedMovieInfo.posterPathUrl,
        placeholder: (context, url) => LoadingWidget(),
        errorWidget: (context, url, error) => placeholder,
        fit: BoxFit.contain,
        width: 64,
      );
    }
  }
}
