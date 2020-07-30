import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/actor/actor_info_model.dart';
import 'package:movie_time/data/actor/actor_info_remote_data_source.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ActorInfoRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ActorInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture("actor.json"), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Somethings went wrong", 404));
  }

  group("getActorById", () {
    final actorId = 287;
    final movieInfoModel =
        ActorInfoModel.fromJson(json.decode(fixture("actor.json")));

    test(
      "should perform GET request on a URL with id being at the endpoint",
      () {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getActorById(actorId);
        // assert
        verify(mockHttpClient.get("https://api.themoviedb.org/3/person/$actorId?api_key=$API_KEY&append_to_response=combined_credits"));
      },
    );

    test(
      "should return ActorInfo when the response code is 200 (success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getActorById(actorId);
        // assert
        expect(result, equals(movieInfoModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getActorById;
        // assert
        expect(() => call(actorId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
