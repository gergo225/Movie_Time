import 'package:movie_time/domain/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/media_list.dart';

class GetHomeInfo extends UseCase<HomeInfo, NoParams> {
  final HomeInfoRepository repository;

  GetHomeInfo(this.repository);

  @override
  Future<Either<Failure, HomeInfo>> call(NoParams params) async {
    bool failureOccurred = false;
    Failure failure;

    // Get movies
    Either<Failure, MediaList> eitherTrendingOrFailureMovies =
        await repository.getTrendingMovies();

    MediaList trendingMovies;
    eitherTrendingOrFailureMovies.fold(
      (f) {
        failureOccurred = true;
        failure = f;
      },
      (movieList) {
        trendingMovies = movieList;
      },
    );

    Map<int, MediaList> genreMovies = {};

    await Future.forEach(GenreUtil.allMovieGenres, (genreId) async {
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

    // Get series
    Either<Failure, MediaList> eitherTrendingOrFailureSeries =
        await repository.getTrendingSeries();

    MediaList trendingSeries;
    eitherTrendingOrFailureSeries.fold((f) {
      failureOccurred = true;
      failure = f;
    }, (seriesList) {
      trendingSeries = seriesList;
    });

    Map<int, MediaList> genreSeries = {};

    await Future.forEach(GenreUtil.allSeriesGenres, (genreId) async {
      final failureOrSeries = await repository.getSeriesByGenre(genreId);

      failureOrSeries.fold((f) {
        failureOccurred = true;
        failure = f;
      }, (seriesList) {
        genreSeries[genreId] = seriesList;
      });
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
          trendingSeries: trendingSeries,
          actionSeries: genreSeries[GenreUtil.action],
          animationSeries: genreSeries[GenreUtil.animation],
          dramaSeries: genreSeries[GenreUtil.drama],
          comedySeries: genreSeries[GenreUtil.comedy],
          scifiSeries: genreSeries[GenreUtil.scienceFiction],
          horrorSeries: genreSeries[GenreUtil.horror],
        ),
      );
    }
  }
}
