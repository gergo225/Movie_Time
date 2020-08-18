import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/media_list.dart';
import 'package:movie_time/domain/home/short_media_info.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';
import 'package:movie_time/presentation/search/search_page.dart';
import 'package:movie_time/presentation/series/series_info_page.dart';

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
  MediaType currentMediaType = MediaType.movie;

  @override
  Widget build(BuildContext context) {
    final List<MediaList> movieLists = [
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

    final List<String> movieListNames = List<String>.from(
      movieLists.map((movieList) => movieList.listName),
    );

    final List<MediaList> seriesLists = [
      widget.homeInfo.trendingSeries,
      widget.homeInfo.actionSeries,
      widget.homeInfo.animationMovies,
      widget.homeInfo.dramaSeries,
      widget.homeInfo.comedySeries,
      widget.homeInfo.scifiSeries,
      widget.homeInfo.horrorSeries,
    ];

    final List<String> seriesListNames = List<String>.from(seriesLists.map(
      (series) => series.listName,
    ));

    return Scaffold(
      drawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: false,
      body: LayoutBuilder(builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        List<MediaList> selectedMediaLists =
            currentMediaType == MediaType.movie ? movieLists : seriesLists;
        List<String> selectedMediaListNames =
            currentMediaType == MediaType.movie
                ? movieListNames
                : seriesListNames;

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
                    itemCount:
                        selectedMediaLists[selectedListIndex].mediaList.length,
                    itemBuilder: (context, index) {
                      return PlatformIndependentImage(
                        imageUrl: selectedMediaLists[selectedListIndex]
                            .mediaList[index]
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
                              child: _buildHomeMedia(
                                  context,
                                  selectedMediaLists[selectedListIndex],
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
                          child: _buildCategoryChooser(selectedMediaListNames),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: AppColors.appBarBackground,
                            child: Row(
                              children: [
                                _buildMenuButton(context),
                                Spacer(),
                                Text(
                                  currentMediaType == MediaType.movie
                                      ? AppStrings.movies
                                      : AppStrings.series,
                                  style: AppTextStyles.homeAppBarTitle,
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

  Widget _buildMenuButton(BuildContext context) {
    return Material(
      color: AppColors.appBarIconBackground,
      type: MaterialType.button,
      child: IconButton(
        icon: Icon(Icons.menu),
        iconSize: 28,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Text("Movie Time app"),
                  Icon(
                    Icons.movie,
                    size: 120,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(AppStrings.movies),
                  onTap: () {
                    if (currentMediaType != MediaType.movie) {
                      setState(() {
                        currentMediaType = MediaType.movie;
                        if (selectedListIndex != 0) {
                          selectedListIndex = 0;
                        }
                      });
                      _goToFirstPage(pageController);
                    }
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text(AppStrings.series),
                  onTap: () {
                    if (currentMediaType != MediaType.tv) {
                      setState(() {
                        currentMediaType = MediaType.tv;
                        if (selectedListIndex != 0) {
                          selectedListIndex = 0;
                        }
                      });
                      _goToFirstPage(pageController);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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

  Widget _buildCategoryChooser(List<String> mediaListNames) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 24),
      itemCount: mediaListNames.length,
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
              if (!isSelected) {
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
            mediaListNames[index],
            style: isSelected
                ? AppTextStyles.homeCategorySelected
                : AppTextStyles.homeCategoryUnselected,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );
      },
    );
  }

  Widget _buildHomeMedia(
      BuildContext context, MediaList mediaList, Size screenSize) {
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
        itemCount: mediaList.mediaList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ShortMediaInfo mediaInfo = mediaList.mediaList[index];
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
                  onTap: () =>
                      _navigateToMedia(context, currentMediaType, mediaInfo.id),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: PlatformIndependentImage(
                        imageUrl: mediaInfo.posterPathUrl,
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
                    mediaInfo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.homeMovieTitle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToMedia(
      BuildContext context, MediaType currentMediaType, int mediaId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return currentMediaType == MediaType.movie
              ? MovieInfoPage(movieId: mediaId)
              : SeriesInfoPage(seriesId: mediaId);
        },
      ),
    );
  }

  void _goToFirstPage(PageController controller) {
    controller.animateToPage(
      0,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }
}
