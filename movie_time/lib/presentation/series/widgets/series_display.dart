import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/domain/series/series_info.dart';
import 'package:movie_time/presentation/core/utils/color_utils.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class SeriesDisplay extends StatefulWidget {
  final SeriesInfo seriesInfo;

  SeriesDisplay({Key key, @required this.seriesInfo})
      : assert(seriesInfo != null),
        super(key: key);

  @override
  _SeriesDisplayState createState() => _SeriesDisplayState();
}

class _SeriesDisplayState extends State<SeriesDisplay> {
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
        widget.seriesInfo.posterPathUrl ?? widget.seriesInfo.backdropPathUrl;
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
              imageUrl: widget.seriesInfo.backdropPathUrl,
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
                      imageUrl: widget.seriesInfo.posterPathUrl,
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
                          widget.seriesInfo.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .apply(color: textColor),
                        ),
                        Text(
                          widget.seriesInfo.genresString,
                          style: AppTextStyles.movieGenres.copyWith(
                            color: textColor.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _valueAndDescription(context,
                                widget.seriesInfo.rating.toString(), "Rating"),
                            _valueAndDescription(
                                context,
                                widget.seriesInfo.episodeRuntimeInMinutes
                                    .toString(),
                                AppStrings.runtime),
                            _valueAndDescription(
                                context,
                                widget.seriesInfo.releaseYearAndMonth,
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
          style: AppTextStyles.movieValueAndDescriptionValue.copyWith(
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
    final TextStyle infoPrefixTextStyle =
        AppTextStyles.seriesInfoPrefix.copyWith(color: textColor);
    final TextStyle infoTextStyle =
        AppTextStyles.seriesInfo.copyWith(color: textColor);
    var padding = EdgeInsets.symmetric(horizontal: 12);

    Widget actorsOrNone = (widget.seriesInfo.actors.isNotEmpty)
        ? ListView.separated(
            padding: padding,
            scrollDirection: Axis.horizontal,
            itemCount: min(widget.seriesInfo.actors.length, 10),
            itemBuilder: (context, index) => ActorInfoItem.mobile(
              actorInfo: widget.seriesInfo.actors[index],
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

    List<Widget> nextAirDate = [
      SizedBox(height: 2),
      Padding(
        padding: padding,
        child: Row(
          children: [
            Text(
              AppStrings.nextAirDate,
              style: infoPrefixTextStyle,
            ),
            Text(
              widget.seriesInfo.nextEpisodeReleaseDateString,
              style: infoTextStyle,
            ),
          ],
        ),
      ),
    ];

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
                widget.seriesInfo.overview,
                style: TextStyle(color: textColor),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: padding,
              child: Row(
                children: [
                  Text(
                    AppStrings.seasonCount,
                    style: infoPrefixTextStyle,
                  ),
                  Text(
                    widget.seriesInfo.seasonCount.toString(),
                    style: infoTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: padding,
              child: Row(
                children: [
                  Text(
                    AppStrings.status,
                    style: infoPrefixTextStyle,
                  ),
                  Text(
                    widget.seriesInfo.status,
                    style: infoTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: padding,
              child: Row(
                children: [
                  Text(
                    AppStrings.lastAirDate,
                    style: infoPrefixTextStyle,
                  ),
                  Text(
                    widget.seriesInfo.latestEpisodeReleaseDateString,
                    style: infoTextStyle,
                  ),
                ],
              ),
            ),
            if (widget.seriesInfo.nextEpisodeReleaseDate != null)
              ...nextAirDate,
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
            SizedBox(height: 8),
            FlatButton(
              textColor: subtitleTextColor,
              visualDensity: VisualDensity(
                vertical: VisualDensity.maximumDensity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.allSeasons,
                    style: AppTextStyles.seriesAllSeasons,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ],
              ),
              onPressed: () {
                // TODO: Navigate to all seasons page
              },
            ),
          ],
        ),
      ),
    );
  }
}
