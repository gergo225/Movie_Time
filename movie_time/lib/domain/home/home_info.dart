import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

class HomeInfo extends Equatable {
  final MovieList<TrendingMovieInfo> trendingMovies;
  final MovieList<ShortMovieInfo> actionMovies;
  final MovieList<ShortMovieInfo> adventureMovies;
  final MovieList<ShortMovieInfo> animationMovies;
  final MovieList<ShortMovieInfo> dramaMovies;
  final MovieList<ShortMovieInfo> comedyMovies;
  final MovieList<ShortMovieInfo> thrillerMovies;
  final MovieList<ShortMovieInfo> horrorMovies;
  final MovieList<ShortMovieInfo> romanceMovies;

  HomeInfo({
    @required this.trendingMovies,
    @required this.actionMovies,
    @required this.adventureMovies,
    @required this.animationMovies,
    @required this.dramaMovies,
    @required this.comedyMovies,
    @required this.thrillerMovies,
    @required this.horrorMovies,
    @required this.romanceMovies,
  });

  @override
  List get props => [
        trendingMovies,
        actionMovies,
        adventureMovies,
        animationMovies,
        comedyMovies,
        thrillerMovies,
        horrorMovies,
        romanceMovies,
      ];
}
