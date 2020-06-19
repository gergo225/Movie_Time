import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_movie_info.dart';

class ActorInfo extends Equatable {
  final int id;
  final String name;
  final String bio;
  final String birthday;
  final String imagePath;
  final List<ActorMovieInfo> movies;

  ActorInfo({
    @required this.id,
    @required this.name,
    @required this.bio,
    @required this.birthday,
    @required this.imagePath,
    @required this.movies,
  });

  @override
  List get props => [id, name, bio, birthday, imagePath, movies];
}
