import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MovieInfo extends Equatable {
  final String title;
  final int id;
  final String releaseDate;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final double rating;
  final int runtimeInMinutes;
  final List<String> genres;

  MovieInfo({
    @required this.title,
    @required this.id,
    @required this.releaseDate,
    @required this.overview,
    @required this.backdropPath,
    @required this.posterPath,
    @required this.rating,
    @required this.runtimeInMinutes,
    @required this.genres,
  }) : super([
          title,
          id,
          releaseDate,
          overview,
          backdropPath,
          posterPath,
          rating,
          runtimeInMinutes,
          genres
        ]);
}
