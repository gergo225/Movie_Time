import '../../domain/entities/movie_info.dart';
import 'package:meta/meta.dart';

class MovieInfoModel extends MovieInfo {
  MovieInfoModel({
    @required String title,
    @required int id,
    @required String releaseDate,
    @required String overview,
    @required String backdropPath,
    @required String posterPath,
    @required double rating,
    @required int runtimeInMinutes,
    @required List<String> genres,
  }) : super(
          title: title,
          id: id,
          releaseDate: releaseDate,
          overview: overview,
          backdropPath: backdropPath,
          posterPath: posterPath,
          rating: rating,
          runtimeInMinutes: runtimeInMinutes,
          genres: genres,
        );

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) {
    return MovieInfoModel(
      title: json["title"],
      id: json["id"],
      releaseDate: json["release_date"],
      overview: json["overview"],
      backdropPath: json["backdrop_path"],
      posterPath: json["poster_path"],
      rating: json["vote_average"],
      runtimeInMinutes: json["runtime"],
      genres: List<String>.from(json["genres"]
          .map((genre) => genre["name"])), // get only genre names as strings
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "release_date": releaseDate,
      "overview": overview,
      "backdrop_path": backdropPath,
      "poster_path": posterPath,
      "vote_average": rating,
      "runtime": runtimeInMinutes,
      "genres": genres,
    };
  }
}
