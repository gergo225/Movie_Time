import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/actor/actor_credit_info.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';
import 'package:movie_time/domain/series/get_series_by_id.dart';
import 'package:movie_time/domain/series/series_info.dart';
import 'package:movie_time/domain/series/series_info_repository.dart';

class MockSeriesInfoRepository extends Mock implements SeriesInfoRepository {}

class TestFailure extends Failure {}

void main() {
  GetSeriesById usecase;
  MockSeriesInfoRepository mockSeriesInfoRepository;

  setUp(() {
    mockSeriesInfoRepository = MockSeriesInfoRepository();
    usecase = GetSeriesById(mockSeriesInfoRepository);
  });

  final seriesId = 123;
  final seriesInfo = SeriesInfo(
    name: "Test Series Title",
    actors: [
      ShortActorInfo(
        name: "Mainie Marrgie",
        id: 69,
        character: "Main Man",
        profileImagePath: "/path1mga1g3ga.jpg",
      ),
    ],
    backdropPath: "/ba224ga9gb3g0g8n9e.jpg",
    episodeRuntimeInMinutes: 48,
    genres: [
      "Action",
      "Comedy",
    ],
    id: 1231,
    latestEpisodeReleaseDate: "2017-08-27",
    nextEpisodeReleaseDate: null,
    overview: "How intersting this is!",
    posterPath: "/wobg2y690b2bnag.jpg",
    rating: 5.8,
    releaseDate: "2013-07-03",
    seasonCount: 8,
    status: "Returning Series",
  );

  test("should get series info of the series with id from the repository",
      () async {
    // Arrange
    when(mockSeriesInfoRepository.getSeriesById(any))
        .thenAnswer((_) async => Right(seriesInfo));
    // Act
    final result = await usecase(Params(id: seriesId));
    // Assert
    expect(result, Right(seriesInfo));
    verify(mockSeriesInfoRepository.getSeriesById(seriesId));
    verifyNoMoreInteractions(mockSeriesInfoRepository);
  });

  final failure = TestFailure();

  test("should return failure when series with id is not found", () async {
    // Arrange
    when(mockSeriesInfoRepository.getSeriesById(any))
        .thenAnswer((_) async => Left(failure));
    // Act
    final result = await usecase(Params(id: seriesId));
    // Assert
    expect(result, Left(failure));
    verify(mockSeriesInfoRepository.getSeriesById(seriesId));
    verifyNoMoreInteractions(mockSeriesInfoRepository);
  });
}
