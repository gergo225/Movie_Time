import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';

import 'search_result_model.dart';

abstract class SearchRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/search/multi?api_key=<<api_key>>&language=en-US&query={title}&page=1
  ///
  /// Throws a [ServerException] for all error codes
  Future<SearchResultModel> searchMediaByTitle(String title);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;

  SearchRemoteDataSourceImpl({@required this.client});

  @override
  Future<SearchResultModel> searchMediaByTitle(String title) async {
    title = title.trim().replaceAll(" ", "%20");
    final response = await client.get(
        "https://api.themoviedb.org/3/search/multi?api_key=$API_KEY&language=en-US&query=$title&page=1");
    if (response.statusCode == 200) {
      return SearchResultModel.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
