import 'package:flutter/foundation.dart';
import 'package:movie_time/data/actor/actor_credit_info_model.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';

class ActorInfoModel extends ActorInfo {
  ActorInfoModel({
    @required int id,
    @required String name,
    @required String bio,
    @required String birthday,
    @required String imagePath,
    @required List<ActorCreditInfo> credits,
  }) : super(
          id: id,
          name: name,
          bio: bio,
          birthday: birthday,
          imagePath: imagePath,
          credits: credits,
        );

  factory ActorInfoModel.fromJson(Map<String, dynamic> json) {
    return ActorInfoModel(
      id: json["id"],
      name: json["name"],
      bio: json["biography"],
      imagePath: json["profile_path"],
      birthday: json["birthday"],
      credits: List<ActorCreditInfo>.from(
        json["combined_credits"]["cast"].map(
          (actorCreditJson) => ActorCreditInfoModel.fromJson(actorCreditJson),
        ),
      ),
    );
  }
}
