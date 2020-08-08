import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';
import 'package:movie_time/domain/series/episode_info.dart';
import 'package:movie_time/domain/series/get_series_by_id.dart' as series;
import 'package:movie_time/domain/series/get_series_season_by_number.dart'
    as season;
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/series/series_info.dart';
import 'package:movie_time/domain/series/short_season_info.dart';
import 'package:movie_time/presentation/series/series_bloc.dart';

class MockGetSeriesById extends Mock implements series.GetSeriesById {}

class MockGetSeriesSeasonByNumber extends Mock
    implements season.GetSeriesSeasonByNumber {}

void main() {
  SeriesBloc bloc;
  MockGetSeriesById mockGetSeriesById;
  MockGetSeriesSeasonByNumber mockGetSeriesSeasonByNumber;

  setUp(() {
    mockGetSeriesById = MockGetSeriesById();
    mockGetSeriesSeasonByNumber = MockGetSeriesSeasonByNumber();

    bloc = SeriesBloc(
      seriesById: mockGetSeriesById,
      seasonByNumber: mockGetSeriesSeasonByNumber,
    );
  });

  test("initial state should be Loading", () {
    // assert
    expect(bloc.state, equals(Loading()));
  });

  group("GetInfoForSeriesById", () {
    final seriesId = 1399;
    final seriesInfo = SeriesInfo(
      name: "Game of Thrones",
      actors: [
        ShortActorInfo(
          id: 239019,
          character: "Jon Snow",
          name: "Kit Harington",
          profileImagePath: "/dwRmvQUkddCx6Xi7vDrdnQL4SJ0.jpg",
        ),
      ],
      backdropPath: "/gX8SYlnL9ZznfZwEH4KJUePBFUM.jpg",
      episodeRuntimeInMinutes: 60,
      genres: [
        "Sci-Fi & Fantasy",
        "Drama",
        "Action & Adventure",
      ],
      id: 1399,
      latestEpisodeReleaseDate: "2017-08-27",
      nextEpisodeReleaseDate: null,
      overview:
          "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
      posterPath: "/gwPSoYUHAKmdyVywgLpKKA4BjRr.jpg",
      rating: 8.2,
      releaseDate: "2011-04-17",
      seasonCount: 7,
      status: "Returning Series",
      seasons: [
        ShortSeasonInfo(
          seasonNumber: 1,
          name: "Season 1",
          posterPath: "/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg",
        ),
      ],
    );

    test(
      "should get data from the usecase",
      () async {
        // arrange
        when(mockGetSeriesById(any)).thenAnswer((_) async => Right(seriesInfo));
        // act
        bloc.add(GetInfoForSeriesById(seriesId));
        await untilCalled(mockGetSeriesById(any));
        // assert
        verify(mockGetSeriesById(series.Params(id: seriesId)));
      },
    );

    test(
      "should emit [SeriesLoaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockGetSeriesById(any)).thenAnswer((_) async => Right(seriesInfo));
        // assert later
        final expected = [
          SeriesLoaded(series: seriesInfo),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForSeriesById(seriesId));
      },
    );

    test(
      "should emit [Error] when getting data fails",
      () async {
        // arrange
        when(mockGetSeriesById(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForSeriesById(seriesId));
      },
    );
  });
  group("GetInfoForSeasonByNumber", () {
    final seriesId = 1399;
    final seasonNumber = 1;
    final seasonInfo = SeasonInfo(
      name: "Season 1",
      seasonNumber: 1,
      overview: "Trouble is brewing in the Seven Kingdoms of Westeros.",
      releaseDate: "2011-04-17",
      posterPath: "/olJ6ivXxCMq3cfujo1IRw30OrsQ.jpg",
      seasonEpisodeCount: 1,
      episodes: [
        EpisodeInfo(
          seasonNumber: 1,
          episodeNumber: 1,
          releaseDate: "2011-04-17",
          name: "Winter Is Coming",
          overview: "Jon Arryn, the Hand of the King, is dead.",
          backdropPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
        ),
      ],
    );

    test(
      "should get data from the usecase",
      () async {
        // arrange
        when(mockGetSeriesSeasonByNumber(any))
            .thenAnswer((_) async => Right(seasonInfo));
        // act
        bloc.add(GetInfoForSeasonByNumber(seriesId, seasonNumber));
        await untilCalled(mockGetSeriesSeasonByNumber(any));
        // assert
        verify(mockGetSeriesSeasonByNumber(season.Params(
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        )));
      },
    );

    test(
      "should emit [SeasonLoaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockGetSeriesSeasonByNumber(any))
            .thenAnswer((_) async => Right(seasonInfo));
        // assert later
        final expected = [
          SeasonLoaded(season: seasonInfo),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForSeasonByNumber(seriesId, seasonNumber));
      },
    );

    test(
      "should emit [Error] when getting data fails",
      () async {
        // arrange
        when(mockGetSeriesSeasonByNumber(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForSeasonByNumber(seriesId, seasonNumber));
      },
    );
  });
}
