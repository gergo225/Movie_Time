import 'package:flutter/material.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';

class ActorDisplay extends StatelessWidget {
  final ActorInfo actorInfo;

  const ActorDisplay({@required this.actorInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              _buildImageAndName(),
              _buildActorDetails(),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: CustomBackButton(),
        ),
      ],
    );
  }

  Widget _buildImageAndName() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48).copyWith(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PlatformIndependentImage(
                width: 128,
                imageUrl: actorInfo.imagePathUrl,
                boxFit: BoxFit.cover,
                errorWidget: NoImageWidget.poster(),
                loadingWidget: LoadingWidget(),
              ),
            ),
            SizedBox(height: 8),
            Text(
              actorInfo.name,
              style: AppTextStyles.actorName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActorDetails() {
    final padding = EdgeInsets.symmetric(horizontal: 12);

    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.birthday,
                      style: AppTextStyles.actorBirthdayPrefix,
                    ),
                    Text(
                      actorInfo.birthdayString,
                      style: AppTextStyles.actorBirthday,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  actorInfo.bio,
                  style: AppTextStyles.actorBio,
                ),
                SizedBox(height: 12),
                Text(
                  AppStrings.otherMovies,
                  style: AppTextStyles.subtitle,
                ),
              ],
            ),
          ),
          Container(
            height: 220,
            child: ListView.separated(
              padding: padding,
              scrollDirection: Axis.horizontal,
              itemCount: actorInfo.credits.length,
              itemBuilder: (context, index) {
                final movieInfo = actorInfo.credits[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToMovie(context, movieInfo.id);
                  },
                  child: CustomListItem.mobile(
                    imageUrl: movieInfo.posterPathUrl,
                    topText: movieInfo.title,
                    bottomText: movieInfo.character,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  void _navigateToMovie(BuildContext context, int movieId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieInfoPage(movieId: movieId);
    }));
  }
}
