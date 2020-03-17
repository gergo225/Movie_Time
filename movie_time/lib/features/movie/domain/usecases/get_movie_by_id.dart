import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_time/core/error/failures.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';

class GetMovieById {
  final MovieInfoRepository repository;

  GetMovieById(this.repository);

  Future<Either<Failure, MovieInfo>> call({
    @required int id,
  }) async {
    return await repository.getMovieById(id);
  }
}