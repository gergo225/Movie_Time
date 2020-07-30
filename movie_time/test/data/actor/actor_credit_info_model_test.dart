import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/actor/actor_credit_info_model.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final actorCreditInfoModel = ActorCreditInfoModel(
    character: "Rusty Ryan",
    id: 163,
    posterPath: "/nS3iDLQuy13XY1JH58NNl1rCuNN.jpg",
    title: "Ocean's Twelve",
  );

  test("should be a subclass of ActorCreditInfo entity", () {
    expect(actorCreditInfoModel, isA<ActorCreditInfo>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("actor_credit.json"));
    
    final result = ActorCreditInfoModel.fromJson(jsonMap);

    expect(result, actorCreditInfoModel);
  });
}
