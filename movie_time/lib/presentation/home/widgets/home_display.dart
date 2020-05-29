import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';

class HomeDisplay extends StatefulWidget {
  final HomeInfo homeInfo;

  const HomeDisplay({Key key, @required this.homeInfo})
      : assert(homeInfo != null),
        super(key: key);

  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  final pageController = PageController(viewportFraction: .9, initialPage: 0);
  double backgroundLeftOffset = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<MovieListModel<ShortMovieInfo>> genreMovies = [
      widget.homeInfo.actionMovies,
      widget.homeInfo.adventureMovies,
      widget.homeInfo.animationMovies,
      widget.homeInfo.comedyMovies,
      widget.homeInfo.dramaMovies,
      widget.homeInfo.romanceMovies,
      widget.homeInfo.thrillerMovies,
      widget.homeInfo.horrorMovies,
    ];

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            backgroundLeftOffset = -pageController.page * screenWidth;
          });
        }
      },
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(
              left: backgroundLeftOffset,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.homeInfo.trendingMovies.movieList.length,
                itemBuilder: (context, index) {
                  return PlatformIndependentImage(
                    imageUrl: widget
                        .homeInfo.trendingMovies.movieList[index].posterPathUrl,
                    errorWidget: Container(),
                    loadingWidget: Container(),
                    boxFit: BoxFit.cover,
                    width: screenWidth,
                  );
                },
              ),
            ),
            Positioned.fill(
              top: 32,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Center(child: _buildTrendingMovies(context)),
              ),
            ),
            Positioned(
              top: 4,
              left: 24,
              child: Text(
                widget.homeInfo.trendingMovies.listName,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white.withOpacity(.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingMovies(BuildContext context) {
    return Container(
      // TODO: Figure out height using LayoutBuilder
      height: 610,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.homeInfo.trendingMovies.movieList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          TrendingMovieInfo movieInfo =
              widget.homeInfo.trendingMovies.movieList[index];
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _navigateToMovie(context, movieInfo.id),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: PlatformIndependentImage(
                        imageUrl: movieInfo.posterPathUrl,
                        errorWidget: NoImageWidget.poster(),
                        loadingWidget: Container(),
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  movieInfo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withOpacity(.8),
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(.5, 1),
                      )
                    ],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 26,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieInfo.genres.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 6);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.withOpacity(.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(
                              movieInfo.genres[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToMovie(BuildContext context, int movieId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MovieInfoPage(movieId: movieId);
        },
      ),
    );
  }
}
