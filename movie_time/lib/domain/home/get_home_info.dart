import 'package:movie_time/domain/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

class GetHomeInfo extends UseCase<HomeInfo, NoParams> {
  final HomeInfoRepository repository;

  GetHomeInfo(this.repository);

  @override
  Future<Either<Failure, HomeInfo>> call(NoParams params) async {
    bool failureOccurred = false;
    Failure failure;

    Either<Failure, MovieList<TrendingMovieInfo>> eitherTrendingOrFailure =
        await repository.getTrendingMovies();

    MovieList<TrendingMovieInfo> trendingMovies;
    eitherTrendingOrFailure.fold(
      (f) {
        failureOccurred = true;
        failure = f;
      },
      (movieList) {
        trendingMovies = movieList;
      },
    );

    Map<int, MovieList<ShortMovieInfo>> genreMovies = {};

    await Future.forEach(GenreUtil.allGenres, (genreId) async {
      final failureOrMovies = await repository.getMoviesByGenre(genreId);

      failureOrMovies.fold(
        (f) {
          failureOccurred = true;
          failure = f;
        },
        (movieList) {
          genreMovies[genreId] = movieList;
        },
      );
    });

    if (failureOccurred) {
      return Left(failure);
    } else {
      return Right(
        HomeInfo(
          trendingMovies: trendingMovies,
          actionMovies: genreMovies[GenreUtil.action],
          adventureMovies: genreMovies[GenreUtil.adventure],
          animationMovies: genreMovies[GenreUtil.animation],
          comedyMovies: genreMovies[GenreUtil.comedy],
          dramaMovies: genreMovies[GenreUtil.drama],
          horrorMovies: genreMovies[GenreUtil.horror],
          romanceMovies: genreMovies[GenreUtil.romance],
          thrillerMovies: genreMovies[GenreUtil.thriller],
        ),
      );
    }
  }
}
