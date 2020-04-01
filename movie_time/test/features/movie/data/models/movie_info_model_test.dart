import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/features/movie/data/models/movie_info_model.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final movieInfoModel = MovieInfoModel(
    title: "Fight Club",
    id: 550,
    releaseDate: "1999-10-12",
    overview:
        "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
  );

  test(
    "should be a subclass of MovieInfo entity",
    () async {
      expect(movieInfoModel, isA<MovieInfo>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("movie.json"));

      final result = MovieInfoModel.fromJson(jsonMap);

      expect(result, movieInfoModel);
    },
  );

  test(
    "should return a JSON map containing the proper data",
    () async {
      final result = movieInfoModel.toJson();

      final expectedJsonMap = {
        "title": "Fight Club",
        "id": 550,
        "release_date": "1999-10-12",
        "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
      };

      expect(result, expectedJsonMap);
    },
  );
}