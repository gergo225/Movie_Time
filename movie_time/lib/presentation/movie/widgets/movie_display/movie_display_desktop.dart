import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/core/widgets/no_image_widget.dart';
import 'package:movie_time/presentation/core/widgets/platform_independent_image.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/widgets/widgets.dart';

class MovieDisplayDesktop extends StatelessWidget {
  final MovieInfo movieInfo;

  const MovieDisplayDesktop({Key key, @required this.movieInfo})
      : assert(movieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.3,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(movieInfo.backdropPathUrl),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 24),
                _posterAndTrailer(context),
                SizedBox(width: 64),
                _movieDetails(context),
              ],
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 0,
          child: CustomBackButton(),
        ),
      ],
    );
  }

  Widget _posterAndTrailer(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PlatformIndependentImage(
            imageUrl: movieInfo.bigPosterPathUrl,
            errorWidget: Container(),
            loadingWidget: null,
            boxFit: BoxFit.contain,
            width: 364,
          ),
        ),
        SizedBox(height: 12),
        OpacityOnHoverChanger(
          defaultOpacity: .7,
          opacityOnHover: 1,
          child: Row(children: [
            Text("Play trailer", style: TextStyle(fontSize: 24)),
            Icon(
              Icons.play_arrow,
              color: Colors.red,
              size: 32,
            ),
          ]),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => YouTubeVideo(movieInfo.trailerYouTubeKey),
            ));
          },
        ),
      ],
    );
  }

  Widget _movieDetails(BuildContext context) {
    final int actorsCount =
        movieInfo.actors.length >= 10 ? 10 : movieInfo.actors.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieInfo.title,
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Text(
          movieInfo.genresString,
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StarRating(
              rating: movieInfo.rating,
              starSize: 27,
            ),
            Text(
              movieInfo.rating.toString(),
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(movieInfo.overview),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 160,
              child: Text("Release: ${movieInfo.releaseYearAndMonth}"),
            ),
            Text("Runtime: ${movieInfo.runtimeInHoursAndMinutes}"),
          ],
        ),
        SizedBox(height: 24),
        Text(
          "Actors",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        LimitedBox(
          maxWidth: 482,
          maxHeight: 700,
          // TODO: Unsolved error on horizontal overflow on screens with width smaller than 982
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.from(movieInfo.actors.take(actorsCount).map(
                  (actor) => Container(
                    width: 90,
                    child: ActorInfoItem.desktop(actorInfo: actor),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class OpacityOnHoverChanger extends StatefulWidget {
  final Widget child;
  final double defaultOpacity;
  final double opacityOnHover;
  final Function onTap;

  const OpacityOnHoverChanger({
    @required this.child,
    @required this.defaultOpacity,
    @required this.opacityOnHover,
    @required this.onTap,
  });

  @override
  _OpacityOnHoverChangerState createState() => _OpacityOnHoverChangerState();
}

class _OpacityOnHoverChangerState extends State<OpacityOnHoverChanger> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hover) {
        if (hover != _hovered) {
          setState(() {
            _hovered = hover;
          });
        }
      },
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Opacity(
        opacity: _hovered ? widget.opacityOnHover : widget.defaultOpacity,
        child: widget.child,
      ),
    );
  }
}
