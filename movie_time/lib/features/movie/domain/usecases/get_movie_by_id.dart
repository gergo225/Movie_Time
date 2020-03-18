import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_time/core/error/failures.dart';
import 'package:movie_time/core/usecases/usecase.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';

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