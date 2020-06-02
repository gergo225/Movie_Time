import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
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
  int selectedListIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<MovieList> movieLists = [
      widget.homeInfo.trendingMovies,
      widget.homeInfo.actionMovies,
      widget.homeInfo.adventureMovies,
      widget.homeInfo.animationMovies,
      widget.homeInfo.comedyMovies,
      widget.homeInfo.dramaMovies,
      widget.homeInfo.romanceMovies,
      widget.homeInfo.thrillerMovies,
      widget.homeInfo.horrorMovies,
    ];

    List<String> movieListNames = List<String>.from(
      movieLists.map((movieList) => movieList.listName),
    );

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
                itemCount: movieLists[selectedListIndex].movieList.length,
                itemBuilder: (context, index) {
                  return PlatformIndependentImage(
                    imageUrl: movieLists[selectedListIndex]
                        .movieList[index]
                        .posterPathUrl,
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
                child: Center(
                  child: _buildTrendingMovies(
                    context,
                    movieLists[selectedListIndex],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              height: 32,
              left: 0,
              right: 0,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 24),
                itemCount: movieListNames.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 8);
                },
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedListIndex;
                  return FlatButton(
                    visualDensity: VisualDensity.compact,
                    color:
                        isSelected ? Colors.blue : Colors.grey.withOpacity(0.4),
                    onPressed: () {
                      setState(() {
                        if (index != selectedListIndex) {
                          selectedListIndex = index;
                        }
                        pageController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                    child: Text(
                      movieListNames[index],
                      style: TextStyle(
                        fontSize: 17,
                        color: isSelected ? Colors.black.withAlpha(210) : Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingMovies(BuildContext context, MovieList movieList) {
    return Container(
      // TODO: Figure out height using LayoutBuilder
      height: 516, // 610 with categories at the bottom
      child: PageView.builder(
        controller: pageController,
        itemCount: movieList.movieList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ShortMovieInfo movieInfo = movieList.movieList[index];
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
                // Container(
                //   height: 26,
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: movieInfo.genres.length,
                //     separatorBuilder: (context, index) {
                //       return SizedBox(width: 6);
                //     },
                //     itemBuilder: (context, index) {
                //       return Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(16),
                //           color: Colors.grey.withOpacity(.4),
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8),
                //           child: Center(
                //             child: Text(
                //               movieInfo.genres[index],
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
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
