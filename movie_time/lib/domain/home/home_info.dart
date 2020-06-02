import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/movie_list.dart';

class HomeInfo extends Equatable {
  final MovieList trendingMovies;
  final MovieList actionMovies;
  final MovieList adventureMovies;
  final MovieList animationMovies;
  final MovieList dramaMovies;
  final MovieList comedyMovies;
  final MovieList thrillerMovies;
  final MovieList horrorMovies;
  final MovieList romanceMovies;

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
