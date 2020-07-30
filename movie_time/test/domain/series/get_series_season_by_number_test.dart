import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/series/episode_info.dart';
import 'package:movie_time/domain/series/get_series_season_by_number.dart';
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/series/series_info_repository.dart';

class MockSeriesInfoRepository extends Mock implements SeriesInfoRepository {}

class TestFailure extends Failure {}

void main() {
  GetSeriesSeasonByNumber usecase;
  MockSeriesInfoRepository mockSeriesInfoRepository;

  setUp(() {
    mockSeriesInfoRepository = MockSeriesInfoRepository();
    usecase = GetSeriesSeasonByNumber(mockSeriesInfoRepository);
  });

  final seriesId = 123;
  final seasonNumber = 1;
  final seasonInfo = SeasonInfo(
    name: "Season 1",
    overview: "Pretty basic plot and everything. Boring characters.",
    posterPath: "/nothingh3re.png",
    releaseDate: "2000-02-02",
    seasonEpisodeCount: 4,
    seasonNumber: 1,
    episodes: [
      EpisodeInfo(
        backdropPath: "/3p15od3.jpg",
        name: "Welcomte to Hello World!",
        seasonNumber: 1,
        episodeNumber: 1,
        overview: "Introduction to the main characters.",
        releaseDate: "2000-02-02",
      ),
    ],
  );

  test(
      "should get season info for the season number of the series with id from the repository",
      () async {
    // Arrange
    when(mockSeriesInfoRepository.getSeriesSeasonByNumber(any, any))
        .thenAnswer((_) async => Right(seasonInfo));
    // Act
    final result =
        await usecase(Params(seasonNumber: seasonNumber, seriesId: seriesId));
    // Assert
    expect(result, Right(seasonInfo));
    verify(mockSeriesInfoRepository.getSeriesSeasonByNumber(
        seriesId, seasonNumber));
    verifyNoMoreInteractions(mockSeriesInfoRepository);
  });

  final failure = TestFailure();

  test("should return failure when series with id is not found", () async {
    // Arrange
    when(mockSeriesInfoRepository.getSeriesSeasonByNumber(any, any))
        .thenAnswer((_) async => Left(failure));
    // Act
    final result =
        await usecase(Params(seasonNumber: seasonNumber, seriesId: seriesId));
    // Assert
    expect(result, Left(failure));
    verify(mockSeriesInfoRepository.getSeriesSeasonByNumber(
        seriesId, seasonNumber));
    verifyNoMoreInteractions(mockSeriesInfoRepository);
  });
}
