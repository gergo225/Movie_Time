import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/series/short_season_info.dart';

class ShortSeasonInfoModel extends ShortSeasonInfo {
  ShortSeasonInfoModel({
    @required String name,
    @required String posterPath,
  }) : super(
          name: name,
          posterPath: posterPath,
        );

  factory ShortSeasonInfoModel.fromJson(Map<String, dynamic> json) {
    return ShortSeasonInfoModel(
      name: json["name"],
      posterPath: json["poster_path"],
    );
  }
}
