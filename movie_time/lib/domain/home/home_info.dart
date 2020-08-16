import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/media_list.dart';

class HomeInfo extends Equatable {
  final MediaList trendingMovies;
  final MediaList actionMovies;
  final MediaList adventureMovies;
  final MediaList animationMovies;
  final MediaList dramaMovies;
  final MediaList comedyMovies;
  final MediaList thrillerMovies;
  final MediaList horrorMovies;
  final MediaList romanceMovies;

  final MediaList trendingSeries;
  final MediaList actionSeries;
  final MediaList animationSeries;
  final MediaList dramaSeries;
  final MediaList comedySeries;
  final MediaList scifiSeries;
  final MediaList horrorSeries;

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
    @required this.trendingSeries,
    @required this.actionSeries,
    @required this.animationSeries,
    @required this.dramaSeries,
    @required this.comedySeries,
    @required this.scifiSeries,
    @required this.horrorSeries,
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
        trendingSeries,
        actionSeries,
        animationSeries,
        dramaSeries,
        comedySeries,
        scifiSeries,
        horrorSeries,
      ];
}
