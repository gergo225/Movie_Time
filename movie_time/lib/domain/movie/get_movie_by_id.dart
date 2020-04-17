import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'movie_info.dart';
import 'movie_info_repository.dart';

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