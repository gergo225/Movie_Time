import 'package:flutter/material.dart';
import 'package:movie_time/domain/series/short_season_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';

import 'season_info_page.dart';

class AllSeasonsPage extends StatelessWidget {
  final int seriesId;
  final List<ShortSeasonInfo> seasons;

  AllSeasonsPage({
    @required this.seriesId,
    @required this.seasons,
  }) : assert(seasons != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: GridView.extent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            children: seasons
                .map(
                  (seasonInfo) => GestureDetector(
                    onTap: () {
                      _navigateToSeason(
                          context, seriesId, seasonInfo.seasonNumber);
                    },
                    child: GridTile(
                      footer: GridTileBar(
                        title: Text(
                          seasonInfo.name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      child: PlatformIndependentImage(
                        boxFit: BoxFit.cover,
                        errorWidget: NoImageWidget.poster(),
                        loadingWidget: LoadingWidget(),
                        imageUrl: seasonInfo.posterPathUrl,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        CustomBackButton(),
      ],
    );
  }

  void _navigateToSeason(BuildContext context, int seriesId, int seasonNumber) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SeasonInfoPage(
        seriesId: seriesId,
        seasonNumber: seasonNumber,
      ),
    ));
  }
}
