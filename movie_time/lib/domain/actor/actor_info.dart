import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class ActorInfo extends Equatable {
  final int id;
  final String name;
  final String bio;
  final String birthday;
  final String imagePath;
  final List<ActorCreditInfo> credits;

  ActorInfo({
    @required this.id,
    @required this.name,
    @required this.bio,
    @required this.birthday,
    @required this.imagePath,
    @required this.credits,
  });

  String get imagePathUrl => createSmallImageLink(imagePath);
  String get birthdayString => (birthday != null) ? "$birthday" : "-";

  @override
  List get props => [id, name, bio, birthday, imagePath, credits];
}
