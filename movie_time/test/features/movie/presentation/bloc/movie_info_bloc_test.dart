import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/error/failure.dart';
import 'package:movie_time/core/usecases/usecase.dart';
import 'package:movie_time/core/util/input_converter.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';
import 'package:movie_time/features/movie/domain/usecases/get_latest_movie.dart';
import 'package:movie_time/features/movie/domain/usecases/get_movie_by_id.dart';
import 'package:movie_time/features/movie/presentation/bloc/movie_info_bloc.dart';

class MockGetMovieById extends Mock implements GetMovieById {}

class MockGetLatestMovie extends Mock implements GetLatestMovie {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MovieInfoBloc bloc;
  MockGetMovieById mockGetMovieById;
  MockGetLatestMovie mockGetLatestMovie;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetMovieById = MockGetMovieById();
    mockGetLatestMovie = MockGetLatestMovie();
    mockInputConverter = MockInputConverter();

    bloc = MovieInfoBloc(
      byId: mockGetMovieById,
      latest: mockGetLatestMovie,
      inputConverter: mockInputConverter,
    );
  });

  test("initial state should be Empty", () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group("GetInfoForMovieById", () {
    final idString = "550";
    // successful output of the InputConverter
    final idParsed = int.parse(idString);
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
    );

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Right(idParsed));

    test(
      "should call the InputConverter to validate and convert the string to an unsigned int",
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // act
        bloc.add(GetInfoForMovieById(idString));
        await untilCalled(mockInputConverter.stringToUnsignedInt(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInt(idString));
      },
    );

    test(
      "should emit [Error] when the input is invalid",
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          // the initial state is always emitted first
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForMovieById(idString));
      },
    );

    test(
      "should get data from the concrete usecase",
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetMovieById(any)).thenAnswer((_) async => Right(movieInfo));
        // act
        bloc.add(GetInfoForMovieById(idString));
        await untilCalled(mockGetMovieById(any));
        // assert
        verify(mockGetMovieById(Params(id: idParsed)));
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetMovieById(any)).thenAnswer((_) async => Right(movieInfo));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(movie: movieInfo),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForMovieById(idString));
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetMovieById(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForMovieById(idString));
      },
    );
  });

  group("GetInfoForLatestMovie", () {
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
      "should get data from the latest usecase",
      () async {
        // arrange
        when(mockGetLatestMovie(any)).thenAnswer((_) async => Right(movieInfo));
        // act
        bloc.add(GetInfoForLatestMovie());
        await untilCalled(mockGetLatestMovie(any));
        // assert
        verify(mockGetLatestMovie(NoParams()));
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockGetLatestMovie(any)).thenAnswer((_) async => Right(movieInfo));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(movie: movieInfo),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForLatestMovie());
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        when(mockGetLatestMovie(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetInfoForLatestMovie());
      },
    );
  });
}
