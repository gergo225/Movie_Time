import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';
import 'package:movie_time/presentation/movie/movie_info_bloc.dart';

class MockGetMovieById extends Mock implements GetMovieById {}

void main() {
  MovieInfoBloc bloc;
  MockGetMovieById mockGetMovieById;

  setUp(() {
    mockGetMovieById = MockGetMovieById();

    bloc = MovieInfoBloc(byId: mockGetMovieById);
  });

  group("GetInfoForMovieById", () {
    final movieId = 550;
    // MovieInfo instance
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
      actors: [
        ShortActorInfo(
          id: 819,
          name: "Edward Norton",
          character: "The Narrator",
          profileImagePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg",
        )
      ],
      trailerYouTubeKey: "BdJKm16Co6M",
    );

    test(
      "should get data from the concrete usecase",
      () async {
        // arrange
        when(mockGetMovieById(any)).thenAnswer((_) async => Right(movieInfo));
        // act
        bloc.add(GetInfoForMovieById(movieId));
        await untilCalled(mockGetMovieById(any));
        // assert
        verify(mockGetMovieById(Params(id: movieId)));
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockGetMovieById(any)).thenAnswer((_) async => Right(movieInfo));
        // assert later
        final expected = [
          Loading(),
          Loaded(movie: movieInfo),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForMovieById(movieId));
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        when(mockGetMovieById(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForMovieById(movieId));
      },
    );
  });
}
