import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/search/search_media_by_title.dart';
import 'package:movie_time/domain/search/search_result.dart';
import 'package:movie_time/domain/search/searched_media_info.dart';
import 'package:movie_time/presentation/search/search_bloc.dart';

class MockSearchMediaByTitle extends Mock implements SearchMediaByTitle {}

void main() {
  SearchBloc bloc;
  MockSearchMediaByTitle mockSearchMediaByTitle;

  setUp(() {
    mockSearchMediaByTitle = MockSearchMediaByTitle();
    bloc = SearchBloc(
      byTitle: mockSearchMediaByTitle,
    );
  });

  test("initial state should be Empty", () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group("GetSearchesForTitle", () {
    final mediaTitle = "Avengers";
    final searchResult = SearchResult(
      movies: [
        SearchedMediaInfo(
          title: "The Avengers",
          id: 24428,
          releaseYear: 2012,
          posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
          rating: 7.33,
          mediaType: MediaType.movie,
        ),
      ],
      series: [
        SearchedMediaInfo(
          title: "Marvel's Avengers Assemble",
          releaseYear: 2013,
          id: 59427,
          posterPath: "/vchDkX1DtqTy3bIDJ7YqmSbX965.jpg",
          rating: 7.7,
          mediaType: MediaType.tv,
        ),
      ],
    );

    test(
      "should get search results from the usecase",
      () async {
        // arrange
        when(mockSearchMediaByTitle(any))
            .thenAnswer((_) async => Right(searchResult));
        // act
        bloc.add(GetSearchesForTitle(mediaTitle));
        await untilCalled(mockSearchMediaByTitle(any));
        // assert
        verify(mockSearchMediaByTitle(Params(title: mediaTitle)));
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockSearchMediaByTitle(any))
            .thenAnswer((_) async => Right(searchResult));
        // assert later
        final expected = [
          Loading(),
          Loaded(searchResult: searchResult),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetSearchesForTitle(mediaTitle));
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        when(mockSearchMediaByTitle(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetSearchesForTitle(mediaTitle));
      },
    );
  });
}
