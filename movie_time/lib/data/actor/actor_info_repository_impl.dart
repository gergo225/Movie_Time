import 'package:flutter/foundation.dart';
import 'package:movie_time/data/actor/actor_info_remote_data_source.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/domain/actor/actor_info.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/actor/actor_info_repository.dart';
import 'package:movie_time/domain/core/failure.dart';

class ActorInfoRepositoryImpl implements ActorInfoRepository {
  final NetworkInfo networkInfo;
  final ActorInfoRemoteDataSource remoteDataSource;

  ActorInfoRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ActorInfo>> getActorById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteActor = await remoteDataSource.getActorById(id);
        return Right(remoteActor);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
