import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/series/season_info_model.dart';
import 'package:movie_time/data/series/series_info_model.dart';
import 'package:http/http.dart' as http;

abstract class SeriesInfoRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/tv/{id}?api_key=<<API_KEY>>&append_to_response=credits
  /// 
  /// Throws a [ServerException] for all error codes
  Future<SeriesInfoModel> getSeriesById(int id);

  /// Calls the https://api.themoviedb.org/3/tv/{seriesId}/season/{seasonNumber}?api_key=<<API_KEY>>
  /// 
  /// Throws a [ServerException] for all error codes
  Future<SeasonInfoModel> getSeriesSeasonByNumber(int seriesId, int seasonNumber);
}

class SeriesInfoRemoteDataSourceImpl implements SeriesInfoRemoteDataSource {
  final http.Client client;

  SeriesInfoRemoteDataSourceImpl({@required this.client});

  @override
  Future<SeriesInfoModel> getSeriesById(int id) async {
    final response = await client.get("https://api.themoviedb.org/3/tv/$id?api_key=$API_KEY&append_to_response=credits");
    if (response.statusCode == 200) {
      return SeriesInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonInfoModel> getSeriesSeasonByNumber(int seriesId, int seasonNumber) async {
    final response = await client.get("https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return SeasonInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}