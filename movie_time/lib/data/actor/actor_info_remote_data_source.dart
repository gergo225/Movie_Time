import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_time/data/actor/actor_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';

abstract class ActorInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/person/{id}?api_key=<<api_key>>&append_to_response=movie_credits
  ///
  /// Throws a [ServerException] for all error codes
  Future<ActorInfoModel> getActorById(int id);
}

class ActorInfoRemoteDataSourceImpl implements ActorInfoRemoteDataSource {
  final http.Client client;

  ActorInfoRemoteDataSourceImpl({@required this.client});

  @override
  Future<ActorInfoModel> getActorById(int id) async {
    final response = await client.get(
        "https://api.themoviedb.org/3/person/$id?api_key=$API_KEY&append_to_response=movie_credits");

    if (response.statusCode == 200) {
      return ActorInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
