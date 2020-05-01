import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/short_actor_info.dart';
import 'package:movie_time/presentation/core/widgets/loading_widget.dart';
import 'package:movie_time/presentation/core/widgets/no_image_widget.dart';
import 'package:movie_time/presentation/core/widgets/platform_independent_image.dart';

class ActorInfoItem extends StatelessWidget {
  final ShortActorInfo actorInfo;

  const ActorInfoItem({Key key, @required this.actorInfo})
      : assert(actorInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Text(
            actorInfo.character,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
