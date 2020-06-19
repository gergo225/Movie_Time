import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:movie_time/domain/core/failure.dart';

abstract class ActorInfoRepository {
  Future<Either<Failure, ActorInfo>> getActorById(int id);
}