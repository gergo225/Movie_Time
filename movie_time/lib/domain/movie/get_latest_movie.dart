import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'movie_info.dart';
import 'movie_info_repository.dart';

class GetLatestMovie extends UseCase<MovieInfo, NoParams> {
  final MovieInfoRepository repository;

  GetLatestMovie(this.repository);

  @override
  Future<Either<Failure, MovieInfo>> call(NoParams params) async {
    return await repository.getLatestMovie();
  }
}
