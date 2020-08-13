import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/core/utils/color_utils.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
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
  bool initialising = true;

  Color backgroundColor = AppColors.defaultMovieBackground;
  Color textColor = AppColors.defaultMovieText;
  Color subtitleTextColor = AppColors.defaultMovieSubtitle;
  Color actorBackgroundColor = AppColors.defaultCustomListItemBackground;
  Color actorTextColor = AppColors.defaultCustomListItemText;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      initialising = false;
    } else {
      _initialisePalette();
    }
  }

  void _initialisePalette() async {
    String imagePath =
        widget.movieInfo.posterPathUrl ?? widget.movieInfo.backdropPathUrl;
    if (imagePath != null) {
      PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
          NetworkImage(imagePath, scale: 1));

      PaletteColor paletteColor = palette.dominantColor;
      backgroundColor = paletteColor.color;
      textColor = paletteColor.bodyTextColor;
      subtitleTextColor = paletteColor.titleTextColor;

      PaletteColor actorColor = palette.darkVibrantColor ??
          palette.lightVibrantColor ??
          PaletteColor(darkenColorBy(backgroundColor, 16), 1);
      actorBackgroundColor = actorColor.color;
      actorTextColor = actorColor.bodyTextColor;

      setState(() {});
    }
    initialising = false;
  }

  @override
  Widget build(BuildContext context) {
    final double topPartHeight = MediaQuery.of(context).size.height / 3;
    if (initialising) {
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
                          style: AppTextStyles.genres.copyWith(
                            color: textColor.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _valueAndDescription(
                                context,
                                widget.movieInfo.rating.toString(),
                                AppStrings.rating),
                            _valueAndDescription(
                                context,
                                widget.movieInfo.runtimeInHoursAndMinutes,
                                AppStrings.runtime),
                            _valueAndDescription(
                                context,
                                widget.movieInfo.releaseYearAndMonth,
                                AppStrings.release),
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
      BuildContext context, String value, String description) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.valueAndDescriptionValue.copyWith(
            color: textColor,
          ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyText2.apply(color: textColor),
        ),
      ],
    );
  }

  Widget _moviePartBottom(BuildContext context) {
    final TextStyle subtitleTextStyle = AppTextStyles.subtitle.copyWith(
      color: subtitleTextColor,
    );
    var padding = EdgeInsets.symmetric(horizontal: 12);

    Widget trailerOrEmpty = (widget.movieInfo.trailerYouTubeKey != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: padding,
                child: Text(
                  AppStrings.trailer,
                  style: subtitleTextStyle,
                ),
              ),
              Padding(
                padding: padding,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YouTubeVideo(widget.movieInfo.trailerYouTubeKey),
                ),
              ),
            ],
          )
        : Container();

    Widget actorsOrNone = (widget.movieInfo.actors.isNotEmpty)
        ? ListView.separated(
            padding: padding,
            scrollDirection: Axis.horizontal,
            itemCount: min(widget.movieInfo.actors.length, 10),
            itemBuilder: (context, index) => ActorInfoItem.mobile(
              actorInfo: widget.movieInfo.actors[index],
              backgroundColor: actorBackgroundColor,
              textColor: actorTextColor,
            ),
            separatorBuilder: (context, index) => SizedBox(width: 8),
          )
        : Center(
            child: Text(
              AppStrings.noInfo,
              style: TextStyle(color: textColor),
            ),
          );

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
                AppStrings.actors,
                style: subtitleTextStyle,
              ),
            ),
            Container(
              height: 200,
              child: actorsOrNone,
            ),
            trailerOrEmpty,
            SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}
