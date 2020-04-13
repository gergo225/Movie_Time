import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/error/failure.dart';
import 'package:movie_time/features/search/domain/entities/search_result.dart';
import 'package:movie_time/features/search/domain/entities/searched_movie_info.dart';
import 'package:movie_time/features/search/domain/usecases/search_movie_by_title.dart';
import 'package:movie_time/features/search/presentation/bloc/search_bloc.dart';

class MockSearchMovieByTitle extends Mock implements SearchMovieByTitle {}

void main() {
  SearchBloc bloc;
  MockSearchMovieByTitle mockSearchMovieByTitle;

  setUp(() {
    mockSearchMovieByTitle = MockSearchMovieByTitle();
    bloc = SearchBloc(
      byTitle: mockSearchMovieByTitle,
    );
  });

  test("initial state should be Empty", () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group("GetSearchesForTitle", () {
    final movieTitle = "Avengers";
    final searchResult = SearchResult(results: [
      SearchedMovieInfo(
          title: "The Avengers",
          id: 24428,
          releaseYear: 2012,
          posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
          rating: 7.33),
    ]);

    test(
      "should get search results from the usecase",
      () async {
        // arrange
        when(mockSearchMovieByTitle(any))
            .thenAnswer((_) async => Right(searchResult));
        // act
        bloc.add(GetSearchesForTitle(movieTitle));
        await untilCalled(mockSearchMovieByTitle(any));
        // assert
        verify(mockSearchMovieByTitle(Params(title: movieTitle)));
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockSearchMovieByTitle(any))
            .thenAnswer((_) async => Right(searchResult));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(searchResult: searchResult),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetSearchesForTitle(movieTitle));
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        when(mockSearchMovieByTitle(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetSearchesForTitle(movieTitle));
      },
    );
  });
}
