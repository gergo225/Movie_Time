import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/error/failure.dart';
import 'package:movie_time/core/usecases/usecase.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';
import 'package:movie_time/features/movie/domain/usecases/get_random_movie.dart';

class MockMovieInfoRepository extends Mock implements MovieInfoRepository {}

class TestFailure implements Failure {
  @override
  List get props => throw UnimplementedError();
}

void main() {
  GetRandomMovie usecase;
  MockMovieInfoRepository mockMovieInfoRepository;

  setUp(() {
    mockMovieInfoRepository = MockMovieInfoRepository();
    usecase = GetRandomMovie(mockMovieInfoRepository);
  });

  final latestMovieId = 1000;
  final movieInfo = MovieInfo(
    title: "Fight Club",
    id: 550,
    releaseDate: "1999-10-12",
    overview:
        "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
  );
  test(
    "should get random movie info based on number between 0 and the latest movie id",
    () async {
      when(mockMovieInfoRepository.getLatestMovieId())
          .thenAnswer((_) async => Right(latestMovieId));
      when(mockMovieInfoRepository.getMovieById(any))
          .thenAnswer((_) async => Right(movieInfo));
      // since random number doesn't require any parameters, we pass in NoParams
      final result = await usecase(NoParams());

      expect(result, Right(movieInfo));
      verify(mockMovieInfoRepository.getLatestMovieId());
      verify(mockMovieInfoRepository.getMovieById(any));
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );

  final failure = TestFailure();

  test(
    "should return Failure when latest movie id is not found",
    () async {
      when(mockMovieInfoRepository.getLatestMovieId())
          .thenAnswer((_) async => Left(failure));
      
      final result = await usecase(NoParams());

      expect(result, Left(failure));
      verify(mockMovieInfoRepository.getLatestMovieId());
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );
}
