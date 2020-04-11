import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SearchMovieInfo extends Equatable {
  final String title;
  final int id;
  final int releaseYear;
  final String posterPath;
  final double rating;

  SearchMovieInfo({
    @required this.title,
    @required this.id,
    @required this.releaseYear,
    @required this.posterPath,
    @required this.rating,
  }) : super([title, id, releaseYear, posterPath, rating]);
}
