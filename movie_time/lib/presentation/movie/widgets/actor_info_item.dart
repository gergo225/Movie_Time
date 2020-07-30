import 'package:flutter/material.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';
import 'package:movie_time/presentation/actor/actor_page.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';

class ActorInfoItem extends StatelessWidget {
  final ShortActorInfo actorInfo;
  final Color backgroundColor;
  final Color textColor;
  final bool isDesktop;

  factory ActorInfoItem.mobile({
    @required ShortActorInfo actorInfo,
    Color backgroundColor,
    Color textColor,
  }) =>
      ActorInfoItem(
        actorInfo: actorInfo,
        isDesktop: false,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );

  factory ActorInfoItem.desktop({@required ShortActorInfo actorInfo}) =>
      ActorInfoItem(
        actorInfo: actorInfo,
        isDesktop: true,
      );

  const ActorInfoItem({
    Key key,
    @required this.actorInfo,
    @required this.isDesktop,
    Color backgroundColor,
    Color textColor,
  })  : assert(actorInfo != null),
        backgroundColor = backgroundColor ?? AppColors.defaultCustomListItemBackground,
        textColor = textColor ?? AppColors.defaultCustomListItemText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToActor(context);
      },
      child: mobileOrDesktopItem(isDesktop),
    );
  }

  CustomListItem mobileOrDesktopItem(bool isDesktop) {
    return isDesktop
        ? CustomListItem.desktop(
            topText: actorInfo.name,
            bottomText: actorInfo.character,
            imageUrl: actorInfo.profileImagePathUrl,
          )
        : CustomListItem.mobile(
            topText: actorInfo.name,
            bottomText: actorInfo.character,
            imageUrl: actorInfo.profileImagePathUrl,
            textColor: textColor,
            backgroundColor: backgroundColor,
          );
  }

  void _navigateToActor(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ActorPage(actorId: actorInfo.id);
      },
    ));
  }
}
