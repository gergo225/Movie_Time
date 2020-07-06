import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';
import 'package:movie_time/presentation/search/search_page.dart';

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

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                backgroundLeftOffset = -pageController.page * screenWidth;
              });
            }
            return true;
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
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 80,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Center(
                              child: _buildTrendingMovies(
                                  context,
                                  movieLists[selectedListIndex],
                                  Size(constraints.maxWidth,
                                      constraints.maxHeight)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          height: 32,
                          left: 0,
                          right: 0,
                          child: _buildCategoryChooser(movieListNames),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: AppColors.appBarBackground,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                ),
                                Spacer(),
                                Text(
                                  "Movies",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                _buildSearchButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchButton() {
    return Material(
      color: AppColors.appBarIconBackground,
      type: MaterialType.button,
      child: IconButton(
        icon: Icon(Icons.search),
        iconSize: 28,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchPage(),
          ));
        },
      ),
    );
  }

  Widget _buildCategoryChooser(List<String> movieListNames) {
    return ListView.separated(
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
          color: isSelected
              ? AppColors.categoryBackgroundSelected
              : AppColors.categoryBackgroundUnselected,
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
              color: isSelected
                  ? AppColors.categoryTextSelected
                  : AppColors.categoryTextUnselected,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );
      },
    );
  }

  Widget _buildTrendingMovies(
      BuildContext context, MovieList movieList, Size screenSize) {
    final pageViewHeight = screenSize.height * 0.8;
    final pageViewWidth = screenSize.width * pageController.viewportFraction;
    double titleHeight = 73;
    final posterHeight = pageViewHeight - titleHeight;
    final horizontalMovieItemPadding =
        (3 * pageViewWidth - 2 * posterHeight) / 6;

    if (horizontalMovieItemPadding > 0) {
      titleHeight -= 16;
    }

    return Container(
      height: pageViewHeight,
      child: PageView.builder(
        controller: pageController,
        itemCount: movieList.movieList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ShortMovieInfo movieInfo = movieList.movieList[index];
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: horizontalMovieItemPadding.abs(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Container(
                  height: titleHeight,
                  child: Text(
                    movieInfo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.homeMovieTitle,
                      shadows: [
                        Shadow(
                          color: AppColors.homeMovieTitleShadow,
                          blurRadius: 4,
                          offset: Offset(.5, 1),
                        )
                      ],
                      fontWeight: FontWeight.bold,
                    ),
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
