import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'series_info.dart';
import 'series_info_repository.dart';

class GetSeriesById extends UseCase<SeriesInfo, Params> {
  final SeriesInfoRepository repository;

  GetSeriesById(this.repository);

  Future<Either<Failure, SeriesInfo>> call(Params params) async {
    return await repository.getSeriesById(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}