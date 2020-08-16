import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/media_list.dart';
import 'package:movie_time/domain/home/short_media_info.dart';
import 'package:movie_time/presentation/home/home_bloc.dart';

class MockGetHomeInfo extends Mock implements GetHomeInfo {}

void main() {
  HomeBloc bloc;
  MockGetHomeInfo mockGetHomeInfo;

  setUp(() {
    mockGetHomeInfo = MockGetHomeInfo();
    bloc = HomeBloc(getHomeInfo: mockGetHomeInfo);
  });

  group("GetInfoForHome", () {
    final genreMovieList = MediaList(
      listName: "Action",
      mediaList: [
        ShortMediaInfo(
          id: 23252,
          title: "Many action, much interesting",
          posterPath: "/wowoa2523520%323",
          mediaType: MediaType.movie,
        )
      ],
    );

    final genreSeriesList = MediaList(
      listName: "Action",
      mediaList: [
        ShortMediaInfo(
          id: 2342,
          title: "THE series",
          posterPath: "/ga23tj2gn2bg2ag",
          mediaType: MediaType.tv,
        ),
      ],
    );

    final homeInfo = HomeInfo(
      trendingMovies: MediaList(
        listName: "Trending",
        mediaList: [
          ShortMediaInfo(
            id: 225,
            title: "Some boring title",
            posterPath: "/path25280pos13R",
            mediaType: MediaType.movie,
          ),
        ],
      ),
      actionMovies: genreMovieList,
      adventureMovies: genreMovieList,
      animationMovies: genreMovieList,
      dramaMovies: genreMovieList,
      comedyMovies: genreMovieList,
      thrillerMovies: genreMovieList,
      horrorMovies: genreMovieList,
      romanceMovies: genreMovieList,
      trendingSeries: MediaList(
        listName: "Trending",
        mediaList: [
          ShortMediaInfo(
            id: 252,
            title: "Long, long way",
            posterPath: "/l2gonga0ngasd",
            mediaType: MediaType.tv,
          ),
        ],
      ),
      actionSeries: genreSeriesList,
      animationSeries: genreSeriesList,
      comedySeries: genreSeriesList,
      dramaSeries: genreSeriesList,
      horrorSeries: genreSeriesList,
      scifiSeries: genreSeriesList,
    );

    test("should get home info for the usecase", () async {
      // arrange
      when(mockGetHomeInfo(any)).thenAnswer((_) async => Right(homeInfo));
      // act
      bloc.add(GetInfoForHome());
      await untilCalled(mockGetHomeInfo(any));
      // assert
      verify(mockGetHomeInfo(NoParams()));
    });

    test("initial state should be Loading", () async {
      expect(bloc.state, equals(Loading()));
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
