import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';

class HomeDisplay extends StatelessWidget {
  final HomeInfo homeInfo;

  const HomeDisplay({Key key, @required this.homeInfo})
      : assert(homeInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement home display UI
    List<MovieListModel<ShortMovieInfo>> genreMovies = [
      homeInfo.actionMovies,
      homeInfo.adventureMovies,
      homeInfo.animationMovies,
      homeInfo.comedyMovies,
      homeInfo.dramaMovies,
      homeInfo.romanceMovies,
      homeInfo.thrillerMovies,
      homeInfo.horrorMovies,
    ];
    List<Widget> genreMoviesList = List<Widget>.from(
      genreMovies.map(
        (genreMovie) => _buildGenreMovies(
          genreMovie.listName,
          genreMovie.movieList,
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTrendingMovies(context),
          Column(
            children: genreMoviesList,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingMovies(BuildContext context) {
    // TODO: Implement
    final pageController = PageController(viewportFraction: .8);

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            homeInfo.trendingMovies.listName,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Container(
          height: 500,
          child: PageView.builder(
            controller: pageController,
            itemCount: homeInfo.trendingMovies.movieList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              TrendingMovieInfo movieInfo =
                  homeInfo.trendingMovies.movieList[index];
              return GestureDetector(
                onTap: () => _navigateToMovie(context, movieInfo.id),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
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
                      Text(
                        movieInfo.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(movieInfo.genresString),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenreMovies(String genreName, List<ShortMovieInfo> movies) {
    // TODO: Implement
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            genreName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 8);
            },
            itemBuilder: (context, index) {
              ShortMovieInfo movieInfo = movies[index];

              return GestureDetector(
                onTap: () => _navigateToMovie(context, movieInfo.id),
                child: Container(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
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
                      Text(
                        movieInfo.title,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
