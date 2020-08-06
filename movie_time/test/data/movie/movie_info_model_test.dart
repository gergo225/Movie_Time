import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/movie/movie_info_model.dart';
import 'package:movie_time/data/core/short_actor_info_model.dart';
import 'package:movie_time/domain/movie/movie_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final movieInfoModel = MovieInfoModel(
    title: "Fight Club",
    id: 550,
    releaseDate: "1999-10-12",
    overview:
        "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
    backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
    posterPath: null,
    rating: 7.8,
    genres: ["Drama"],
    runtimeInMinutes: 139,
    actors: [
      ShortActorInfoModel(
        id: 819,
        name: "Edward Norton",
        character: "The Narrator",
        profileImagePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg",
      ),
      ShortActorInfoModel(
        id: 287,
        name: "Brad Pitt",
        character: "Tyler Durden",
        profileImagePath: "/tJiSUYst4ddIaz1zge2LqCtu9tw.jpg",
      ),
    ],
    trailerYouTubeKey: "BdJKm16Co6M",
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
        "overview":
            "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
        "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
        "poster_path": null,
        "vote_average": 7.8,
        "runtime": 139,
        "genres": ["Drama"],
        "credits": {
          "cast": [
            {
              "id": 819,
              "name": "Edward Norton",
              "character": "The Narrator",
              "profile_path": "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"
            },
            {
              "id": 287,
              "name": "Brad Pitt",
              "character": "Tyler Durden",
              "profile_path": "/tJiSUYst4ddIaz1zge2LqCtu9tw.jpg",
            }
          ]
        },
        "videos": {"results": [{"key": "BdJKm16Co6M"}]}
      };

      expect(result, expectedJsonMap);
    },
  );
}
