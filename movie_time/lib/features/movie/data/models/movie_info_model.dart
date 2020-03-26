import '../../domain/entities/movie_info.dart';
import 'package:meta/meta.dart';

class MovieInfoModel extends MovieInfo {
  MovieInfoModel({
    @required String title,
    @required int id,
    @required String releaseDate,
    @required String overview,
  }) : super(
            title: title, id: id, releaseDate: releaseDate, overview: overview);

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) {
    return MovieInfoModel(
      title: json["title"],
      id: json["id"],
      releaseDate: json["release_date"],
      overview: json["overview"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "release_date": releaseDate,
      "overview": overview,
    };
  }
}
