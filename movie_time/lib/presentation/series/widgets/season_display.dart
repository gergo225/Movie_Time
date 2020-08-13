import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/series/widgets/episode_item.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonDisplay extends StatefulWidget {
  final SeasonInfo seasonInfo;

  SeasonDisplay({Key key, @required this.seasonInfo})
      : assert(seasonInfo != null),
        super(key: key);

  @override
  _SeasonDisplayState createState() => _SeasonDisplayState();
}

class _SeasonDisplayState extends State<SeasonDisplay> {
  bool initialising = true;

  Color backgroundColor = AppColors.defaultMovieBackground;
  Color textColor = AppColors.defaultMovieText;
  Color subtitleTextColor = AppColors.defaultMovieSubtitle;

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
    String imagePath = widget.seasonInfo.posterPathUrl;
    if (imagePath != null) {
      PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
          NetworkImage(imagePath, scale: 1));

      PaletteColor paletteColor = palette.dominantColor;
      backgroundColor = paletteColor.color;
      textColor = paletteColor.bodyTextColor;
      subtitleTextColor = paletteColor.titleTextColor;

      setState(() {});
    }
    initialising = false;
  }

  @override
  Widget build(BuildContext context) {
    final double topPartHeight = MediaQuery.of(context).size.height / 4;
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

  Widget _moviePartTop(BuildContext context) => Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PlatformIndependentImage(
                imageUrl: widget.seasonInfo.posterPathUrl,
                errorWidget: NoImageWidget.poster(),
                loadingWidget: LoadingWidget(),
                boxFit: BoxFit.scaleDown,
                width: 100,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.seasonInfo.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: textColor),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _valueAndDescription(
                        context,
                        widget.seasonInfo.seasonEpisodeCount.toString(),
                        AppStrings.episodes,
                      ),
                      _valueAndDescription(
                        context,
                        widget.seasonInfo.releaseDate,
                        AppStrings.release,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
        child: Padding(
          padding: padding,
          child: ListView(
            children: [
              Text(
                widget.seasonInfo.overview,
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 12),
              Text(
                AppStrings.episodes,
                style: subtitleTextStyle,
              ),
              ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.seasonInfo.episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeItem(
                    textColor: textColor,
                    episodeInfo: widget.seasonInfo.episodes[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 4);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
