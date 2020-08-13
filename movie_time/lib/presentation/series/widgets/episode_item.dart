import 'package:flutter/material.dart';
import 'package:movie_time/domain/series/episode_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/series/episode_info_page.dart';

class EpisodeItem extends StatelessWidget {
  final EpisodeInfo episodeInfo;
  final Color textColor;

  const EpisodeItem({
    Key key,
    @required this.episodeInfo,
    @required this.textColor,
  })  : assert(episodeInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 104;

    return InkWell(
      onTap: () {
        _navigateToEpisode(context, episodeInfo);
      },
      child: Container(
        color: Colors.black12,
        height: itemHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episodeInfo.nameWithNumber,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyles.customListItemTop.copyWith(color: textColor),
              ),
              Text(
                episodeInfo.releaseDate,
                style: TextStyle(color: textColor.withOpacity(.6)),
              ),
              SizedBox(height: 4),
              Expanded(
                child: Text(
                  episodeInfo.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: textColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEpisode(BuildContext context, EpisodeInfo episodeInfo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EpisodeInfoPage(episodeInfo: episodeInfo),
    ));
  }
}
