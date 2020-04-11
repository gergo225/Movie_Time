import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/features/search/domain/entities/search_movie_info.dart';
import 'package:movie_time/features/search/domain/entities/search_result.dart';
import 'package:movie_time/features/search/domain/repositories/search_repository.dart';
import 'package:movie_time/features/search/domain/usecases/search_movie_by_title.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  SearchMovieByTitle usecase;
  MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase = SearchMovieByTitle(mockSearchRepository);
  });

  final movieTitle = "Avengers";
  final searchResult = SearchResult(results: [
    SearchMovieInfo(
        title: "The Avengers",
        id: 24428,
        releaseYear: 2012,
        posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
        rating: 7.33),
  ]);

  test(
    "should get search result for movie title from the repository",
    () async {
      // arrange
      when(mockSearchRepository.searchMovieByTitle(any))
          .thenAnswer((_) async => Right(searchResult));
      // act
      final result = await usecase(Params(title: movieTitle));
      expect(result, Right(searchResult));
      // assert
      verify(mockSearchRepository.searchMovieByTitle(movieTitle));
      verifyNoMoreInteractions(mockSearchRepository);
    },
  );
}
