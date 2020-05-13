import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/widgets/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDisplayMobile extends StatefulWidget {
  final MovieInfo movieInfo;

  const MovieDisplayMobile({Key key, @required this.movieInfo})
      : assert(movieInfo != null),
        super(key: key);

  @override
  _MovieDisplayMobileState createState() => _MovieDisplayMobileState();
}

class _MovieDisplayMobileState extends State<MovieDisplayMobile> {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  Color actorBackgroundColor;
  Color actorTextColor;

  @override
  void initState() {
    super.initState();
    _initialisePalette();
  }

  void _initialisePalette() async {
    String imagePath =
        widget.movieInfo.posterPathUrl ?? widget.movieInfo.backdropPathUrl;
    if (imagePath != null) {
      PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
          NetworkImage(imagePath, scale: 1));

      PaletteColor paletteColor = palette.mutedColor ?? palette.dominantColor;
      backgroundColor = paletteColor.color;
      textColor = paletteColor.bodyTextColor;

      PaletteColor actorColor =
          palette.darkVibrantColor ?? palette.lightVibrantColor;
      actorBackgroundColor = actorColor.color;
      actorTextColor = actorColor.bodyTextColor;
      setState(() {});
    } else {
      actorBackgroundColor = Colors.white;
      actorTextColor = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topPartHeight = MediaQuery.of(context).size.height / 3;
    if (actorBackgroundColor == null) {
      return LoadingWidget();
    } else {
      return Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: topPartHeight,
                  child: _moviePartTop(context),
                ),
                _moviePartBottom(context),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: CustomBackButton(),
            ),
          ],
        ),
      );
    }
  }

  Widget _moviePartTop(BuildContext context) => Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PlatformIndependentImage(
              imageUrl: widget.movieInfo.backdropPathUrl,
              errorWidget: NoImageWidget.wide(),
              loadingWidget: LoadingWidget(),
              boxFit: BoxFit.cover,
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
                      imageUrl: widget.movieInfo.posterPathUrl,
                      errorWidget: NoImageWidget.poster(),
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
                          widget.movieInfo.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .apply(color: textColor),
                        ),
                        Text(
                          widget.movieInfo.genresString,
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _valueAndDescription(context,
                                widget.movieInfo.rating.toString(), "Rating"),
                            _valueAndDescription(
                                context,
                                widget.movieInfo.runtimeInHoursAndMinutes,
                                "Runtime"),
                            _valueAndDescription(
                                context,
                                widget.movieInfo.releaseYearAndMonth,
                                "Release date"),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            description,
            style:
                Theme.of(context).textTheme.bodyText2.apply(color: textColor),
          ),
        ],
      );

  Widget _moviePartBottom(BuildContext context) {
    final TextStyle movieBodySubtitleTextStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
    var padding = EdgeInsets.symmetric(horizontal: 12);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundColor, backgroundColor.withOpacity(0.6)],
            stops: [0, .9],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: padding,
              child: Text(
                widget.movieInfo.overview,
                style: TextStyle(color: textColor),
              ),
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
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: padding,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.movieInfo.actors.length >= 10
                          ? 10
                          : widget.movieInfo.actors.length,
                      itemBuilder: (context, index) => ActorInfoItem.mobile(
                        actorInfo: widget.movieInfo.actors[index],
                        backgroundColor: actorBackgroundColor,
                        textColor: actorTextColor,
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
            Padding(
              padding: padding,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: YouTubeVideo(widget.movieInfo.trailerYouTubeKey),
              ),
            ),
            SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}
