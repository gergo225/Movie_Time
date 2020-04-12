import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/search_remote_data_source.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SearchResult>> searchMovieByTitle(
      String title) async {
        if (await networkInfo.isConnected) {
          try {
            final searchResult = await remoteDataSource.searchMovieByTitle(title);
            return Right(searchResult);
          } on ServerException {
            return Left(ServerFailure());
          }
        } else {
          return Left(ConnectionFailure());
        }
      }
}
