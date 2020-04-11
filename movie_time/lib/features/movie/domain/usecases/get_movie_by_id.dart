import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_info.dart';
import '../repositories/movie_info_repository.dart';

class GetMovieById extends UseCase<MovieInfo, Params> {
  final MovieInfoRepository repository;

  GetMovieById(this.repository);

  Future<Either<Failure, MovieInfo>> call(Params params) async {
    return await repository.getMovieById(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id}) : super([id]);
}