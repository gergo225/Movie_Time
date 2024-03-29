import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';

class ShortActorInfoModel extends ShortActorInfo {
  ShortActorInfoModel({
    @required int id,
    @required String name,
    @required String character,
    @required String profileImagePath,
  }) : super(
          id: id,
          name: name,
          character: character,
          profileImagePath: profileImagePath,
        );

  factory ShortActorInfoModel.from(Map<String, dynamic> json) {
    return ShortActorInfoModel(
      id: json["id"],
      name: json["name"],
      character: json["character"],
      profileImagePath: json["profile_path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "character": character,
      "profile_path": profileImagePath,
    };
  }
}
