import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/actor/actor_info_repository.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';

class GetActorById extends UseCase<ActorInfo, Params> {

  final ActorInfoRepository repository;

  GetActorById(this.repository);

  Future<Either<Failure, ActorInfo>> call(Params params) async {
    return await repository.getActorById(params.id);
  }

}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List get props => [id];
}