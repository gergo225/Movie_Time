import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class ShortActorInfo extends Equatable {
  final String id;
  final String name;
  final String character;
  final String profileImagePath;

  ShortActorInfo({
    @required this.id,
    @required this.name,
    @required this.character,
    @required this.profileImagePath,
  });

  String get profileImagePathUrl => createSmallImageLink(profileImagePath);

  @override
  List get props => [id, name, character, profileImagePath];
}
