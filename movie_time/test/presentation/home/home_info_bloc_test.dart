import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/presentation/home/home_bloc.dart';

class MockGetHomeInfo extends Mock implements GetHomeInfo {}

void main() {
  HomeBloc bloc;
  MockGetHomeInfo mockGetHomeInfo;

  setUp(() {
    mockGetHomeInfo = MockGetHomeInfo();
    bloc = HomeBloc(getHomeInfo: mockGetHomeInfo);
  });

  test("initial state should be Loading", () {
    expect(bloc.state, equals(Loading()));
  });

  group("GetInfoForHome", () {
    final genreMovieList = MovieList(
      listName: "Action",
      movieList: [
        ShortMovieInfo(
            id: 23252,
            title: "Many action, much interesting",
            posterPath: "/wowoa2523520%323",
            genres: [GenreUtil.genreIdAndName[GenreUtil.action]])
      ],
    );
    final homeInfo = HomeInfo(
        trendingMovies: MovieList(listName: "Trending", movieList: [
          ShortMovieInfo(
            genres: [GenreUtil.genreIdAndName[GenreUtil.action]],
            id: 225,
            title: "Some boring title",
            posterPath: "/path25280pos13R",
          ),
        ]),
        actionMovies: genreMovieList,
        adventureMovies: genreMovieList,
        animationMovies: genreMovieList,
        dramaMovies: genreMovieList,
        comedyMovies: genreMovieList,
        thrillerMovies: genreMovieList,
        horrorMovies: genreMovieList,
        romanceMovies: genreMovieList);

    test("should get home info for the usecase", () async {
      // arrange
      when(mockGetHomeInfo(any)).thenAnswer((_) async => Right(homeInfo));
      // act
      bloc.add(GetInfoForHome());
      await untilCalled(mockGetHomeInfo(any));
      // assert
      verify(mockGetHomeInfo(NoParams()));
    });

    test("should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      // arrange
      when(mockGetHomeInfo(any)).thenAnswer((_) async => Right(homeInfo));
      // assert later
      final expected = [
        Loading(),
        Loaded(homeInfo: homeInfo),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetInfoForHome());
    });

    test("should emit [Loading, Error] when getting data fails", () async {
      // arrange
      when(mockGetHomeInfo(any)).thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetInfoForHome());
    });
  });
}
