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

  final movieTitle = "fast";
  final searchResult = SearchResult(results: [
    SearchMovieInfo(
        title: "Fast & Furious Presents: Hobbs & Shaw",
        id: 384018,
        releaseYear: 2019,
        posterPath: "/kvpNZAQow5es1tSY6XW2jAZuPPG.jpg",
        rating: 6.7),
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
