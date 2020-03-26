import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/movie_info.dart';
import '../../domain/repositories/movie_info_repository.dart';
import '../datasources/movie_info_remote_data_source.dart';

class MovieInfoRepositoryImpl implements MovieInfoRepository {
  final MovieInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  MovieInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> getLatestMovieId() {
    // TODO: implement getLatestMovieId
    return null;
  }

  @override
  Future<Either<Failure, MovieInfo>> getMovieById(int id) {
    // TODO: implement getMovieById
    return null;
  }

}