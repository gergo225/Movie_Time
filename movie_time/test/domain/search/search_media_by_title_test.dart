import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/search/search_media_by_title.dart';
import 'package:movie_time/domain/search/search_repository.dart';
import 'package:movie_time/domain/search/search_result.dart';
import 'package:movie_time/domain/search/searched_media_info.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  SearchMediaByTitle usecase;
  MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchMediaByTitle(mockSearchRepository);
  });

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
    "should get search result for media title from the repository",
    () async {
      // arrange
      when(mockSearchRepository.searchMediaByTitle(any))
          .thenAnswer((_) async => Right(searchResult));
      // act
      final result = await usecase(Params(title: mediaTitle));
      expect(result, Right(searchResult));
      // assert
      verify(mockSearchRepository.searchMediaByTitle(mediaTitle));
      verifyNoMoreInteractions(mockSearchRepository);
    },
  );
}
