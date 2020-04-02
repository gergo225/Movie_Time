import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/error/failure.dart';
import 'package:movie_time/core/usecases/usecase.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';
import 'package:movie_time/features/movie/domain/usecases/get_latest_movie.dart';

class MockMovieInfoRepository extends Mock implements MovieInfoRepository {}

class TestFailure implements Failure {
  @override
  List get props => throw UnimplementedError();
}

void main() {
  GetLatestMovie usecase;
  MockMovieInfoRepository mockMovieInfoRepository;

  setUp(() {
    mockMovieInfoRepository = MockMovieInfoRepository();
    usecase = GetLatestMovie(mockMovieInfoRepository);
  });

  final movieInfo = MovieInfo(
    title: "Fight Club",
    id: 550,
    releaseDate: "1999-10-12",
    overview:
        "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
  );
  test(
    "should get latest movie info",
    () async {
      when(mockMovieInfoRepository.getLatestMovie())
          .thenAnswer((_) async => Right(movieInfo));
      when(mockMovieInfoRepository.getMovieById(any))
          .thenAnswer((_) async => Right(movieInfo));
      // since the latest movie doesn't require any parameters, we pass in NoParams
      final result = await usecase(NoParams());

      expect(result, Right(movieInfo));
      verify(mockMovieInfoRepository.getLatestMovie());
      verify(mockMovieInfoRepository.getMovieById(any));
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );

  final failure = TestFailure();

  test(
    "should return Failure when latest movie id is not found",
    () async {
      when(mockMovieInfoRepository.getLatestMovie())
          .thenAnswer((_) async => Left(failure));
      
      final result = await usecase(NoParams());

      expect(result, Left(failure));
      verify(mockMovieInfoRepository.getLatestMovie());
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );
}
