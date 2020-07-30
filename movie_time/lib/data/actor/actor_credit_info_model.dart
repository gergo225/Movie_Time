import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';

class ActorCreditInfoModel extends ActorCreditInfo {
  ActorCreditInfoModel({
    @required int id,
    @required String title,
    @required String character,
    @required String posterPath,
  }) : super(
          id: id,
          title: title,
          character: character,
          posterPath: posterPath,
        );

  factory ActorCreditInfoModel.fromJson(Map<String, dynamic> json) {
    return ActorCreditInfoModel(
      id: json["id"],
      title: json["title"],
      character: json["character"],
      posterPath: json["poster_path"],
    );
  }
}
