import 'dart:math';

import 'package:movie_time/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_info.dart';
import '../repositories/movie_info_repository.dart';

class GetRandomMovie extends UseCase<MovieInfo, NoParams> {
  final MovieInfoRepository repository;

  GetRandomMovie(this.repository);

  @override
  Future<Either<Failure, MovieInfo>> call(NoParams params) async {
    var latestMovie = await repository.getLatestMovie();
    return latestMovie.fold(
      (failure) => Left(failure),
      (movieInfo) => repository.getMovieById(Random().nextInt(movieInfo.id)),
    );
  }
}
