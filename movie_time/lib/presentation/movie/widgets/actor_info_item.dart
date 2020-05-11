import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/short_actor_info.dart';
import 'package:movie_time/presentation/core/widgets/loading_widget.dart';
import 'package:movie_time/presentation/core/widgets/no_image_widget.dart';
import 'package:movie_time/presentation/core/widgets/platform_independent_image.dart';

class ActorInfoItem extends StatelessWidget {
  final ShortActorInfo actorInfo;
  final double nameFontSize;
  final double characterFontSize;
  final double aspectRatio;
  final int maxNameLines;

  final Color backgroundColor;
  final Color textColor;

  factory ActorInfoItem.mobile({
    @required ShortActorInfo actorInfo,
    Color backgroundColor,
    Color textColor,
  }) =>
      ActorInfoItem(
        actorInfo: actorInfo,
        aspectRatio: 1 / 2.1,
        nameFontSize: 14,
        characterFontSize: 11,
        maxNameLines: 2,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );

  factory ActorInfoItem.desktop({@required ShortActorInfo actorInfo}) =>
      ActorInfoItem(
        actorInfo: actorInfo,
        nameFontSize: 11,
        characterFontSize: 10,
        aspectRatio: 10 / 18,
        maxNameLines: 1,
      );

  const ActorInfoItem({
    Key key,
    @required this.actorInfo,
    @required this.aspectRatio,
    @required this.nameFontSize,
    @required this.characterFontSize,
    @required this.maxNameLines,
    Color backgroundColor,
    Color textColor,
  })  : assert(actorInfo != null),
        backgroundColor = backgroundColor ?? Colors.white,
        textColor = textColor ?? Colors.black,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: PlatformIndependentImage(
                imageUrl: actorInfo.profileImagePathUrl,
                errorWidget: NoImageWidget.poster(),
                loadingWidget: LoadingWidget(),
                boxFit: BoxFit.contain,
              ),
            ),
            Text(
              actorInfo.name,
              maxLines: maxNameLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: nameFontSize,
                color: textColor,
              ),
            ),
            Text(
              actorInfo.character,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: characterFontSize,
                color: textColor.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
