import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/widgets/widgets.dart';

class MovieDisplay extends StatelessWidget {
  final MovieInfo movieInfo;
  final Color backgroundColor = Colors.blue; // TODO: Change color

  const MovieDisplay({Key key, @required this.movieInfo})
      : assert(movieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(child: _moviePartTop(context)),
          _moviePartBottom(context),
        ],
      ),
    );
  }

  Widget _moviePartTop(BuildContext context) => Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PlatformIndependentImage(
              imageUrl: movieInfo.backdropPathUrl,
              errorWidget: _errorWidget(),
              loadingWidget: LoadingWidget(),
              boxFit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [backgroundColor, Colors.transparent],
                  stops: [0.7, 1],
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: PlatformIndependentImage(
                      imageUrl: movieInfo.posterPathUrl,
                      errorWidget: _errorWidget(),
                      loadingWidget: LoadingWidget(),
                      boxFit: BoxFit.scaleDown,
                      width: 100,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieInfo.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          movieInfo.genresString,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _valueAndDescription(
                                context, movieInfo.rating.toString(), "Rating"),
                            _valueAndDescription(context,
                                movieInfo.runtimeInHoursAndMinutes, "Runtime"),
                            _valueAndDescription(context,
                                movieInfo.releaseYearAndMonth, "Release date"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _valueAndDescription(
    BuildContext context,
    String value,
    String description,
  ) =>
      Column(
        children: [
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      );

  Widget _moviePartBottom(BuildContext context) {
    final TextStyle movieBodySubtitleTextStyle =
        TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
    var padding = EdgeInsets.symmetric(horizontal: 12);

    return Expanded(
      child: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            Padding(
              padding: padding,
              child: Text(movieInfo.overview),
            ),
            SizedBox(height: 12),
            Padding(
              padding: padding,
              child: Text(
                "Actors",
                style: movieBodySubtitleTextStyle,
              ),
            ),
            Container(
              height: 210,
              color: Colors.red, // TODO: Change color
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: padding,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => ActorInfoItem(
                        actorInfo: movieInfo.actors[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: Text(
                "Trailer",
                style: movieBodySubtitleTextStyle,
              ),
            ),
            YouTubeVideo(youTubeVideoKey: movieInfo.trailerYouTubeKey),
          ],
        ),
      ),
    );
  }

  Widget _errorWidget() => Text("Error", style: TextStyle(color: Colors.red));
}
