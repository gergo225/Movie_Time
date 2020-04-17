import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/domain/movie/movie_info_repository.dart';

class MockMovieInfoRepository extends Mock implements MovieInfoRepository {}

class TestFailure implements Failure {
  @override
  List get props => throw UnimplementedError();
}

void main() {
  GetMovieById usecase;
  MockMovieInfoRepository mockMovieInfoRepository;

  setUp(() {
    mockMovieInfoRepository = MockMovieInfoRepository();
    usecase = GetMovieById(mockMovieInfoRepository);
  });

  final movieId = 550;
  final movieInfo = MovieInfo(
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
  );

  test(
    "should get movie info of the movie with id from the repository",
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockMovieInfoRepository.getMovieById(any))
          .thenAnswer((_) async => Right(movieInfo));
      // The "act" phase of the test. Call the not-yet-existent method
      final result = await usecase(Params(id: movieId));
      // UseCase should simply return whatever was returned from the repository
      expect(result, Right(movieInfo));
      // Verify that the method has been called on the Repository
      verify(mockMovieInfoRepository.getMovieById(movieId));
      // Only the above method should be called an nothing more
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );

  final failure = TestFailure();

  test(
    "should get Failure when movie with id is not found",
    () async {
      when(mockMovieInfoRepository.getMovieById(any))
          .thenAnswer((_) async => Left(failure));

      final result = await usecase(Params(id: movieId));

      expect(result, Left(failure));
      verify(mockMovieInfoRepository.getMovieById(movieId));
      verifyNoMoreInteractions(mockMovieInfoRepository);
    },
  );
}
