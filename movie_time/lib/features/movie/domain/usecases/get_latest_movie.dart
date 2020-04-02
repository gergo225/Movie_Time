import 'package:movie_time/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_info.dart';
import '../repositories/movie_info_repository.dart';

class GetLatestMovie extends UseCase<MovieInfo, NoParams> {
  final MovieInfoRepository repository;

  GetLatestMovie(this.repository);

  @override
  Future<Either<Failure, MovieInfo>> call(NoParams params) async {
    return await repository.getLatestMovie();
  }
}
