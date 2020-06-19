import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/actor/actor_movie_info_model.dart';
import 'package:movie_time/domain/actor/actor_movie_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final actorMovieInfoModel = ActorMovieInfoModel(
    character: "Rusty Ryan",
    id: 163,
    posterPath: "/oV3BVdY3UtEHRxpixmntpxHJwSc.jpg",
    title: "Ocean's Twelve",
  );

  test("should be a subclass of ActorMovieInfo entity", () {
    expect(actorMovieInfoModel, isA<ActorMovieInfo>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("actor_movie.json"));
    
    final result = ActorMovieInfoModel.fromJson(jsonMap);

    expect(result, actorMovieInfoModel);
  });
}
