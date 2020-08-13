import 'package:flutter/material.dart';
import 'package:movie_time/domain/series/episode_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';

class EpisodeInfoPage extends StatelessWidget {
  final EpisodeInfo episodeInfo;

  EpisodeInfoPage({@required this.episodeInfo}) : assert(episodeInfo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final double topPartHeight = MediaQuery.of(context).size.height / 4;
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

  Widget _moviePartTop(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(episodeInfo.name,
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _valueAndDescription(
                  context,
                  episodeInfo.seasonNumber.toString(),
                  AppStrings.season,
                ),
                _valueAndDescription(
                  context,
                  episodeInfo.episodeNumber.toString(),
                  AppStrings.episode,
                ),
                _valueAndDescription(
                  context,
                  episodeInfo.releaseDate,
                  AppStrings.release,
                ),
              ],
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
          style: AppTextStyles.movieValueAndDescriptionValue,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _moviePartBottom(BuildContext context) {
    var padding = EdgeInsets.symmetric(horizontal: 12);

    return Expanded(
      child: Padding(
        padding: padding,
        child: ListView(
          children: [
            Text(
              episodeInfo.overview,
            ),
            SizedBox(height: 4),
            PlatformIndependentImage(
              imageUrl: episodeInfo.backdropPathUrl,
              boxFit: BoxFit.cover,
              loadingWidget: LoadingWidget(),
              errorWidget: NoImageWidget.wide(),
            ),
          ],
        ),
      ),
    );
  }
}
