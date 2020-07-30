import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/movie/short_actor_info_model.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortActorInfoModel = ShortActorInfoModel(
    id: 819,
    name: "Edward Norton",
    character: "The Narrator",
    profileImagePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg",
  );

  test("should be a subclass of ShorActorInfo entity", () async {
    expect(shortActorInfoModel, isA<ShortActorInfo>());
  });

  test("should return a valid model", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("short_actor.json"));

    final result = ShortActorInfoModel.from(jsonMap);

    expect(result, shortActorInfoModel);
  });

  test("should return a JSON map containing the proper data", () async {
    final result = shortActorInfoModel.toJson();

    final expectedJsonMap = {
      "id": 819,
      "name": "Edward Norton",
      "character": "The Narrator",
      "profile_path": "/eIkFHNlfretLS1spAcIoihKUS62.jpg",
    };

    expect(result, expectedJsonMap);
  });
}
