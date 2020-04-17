import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network_info.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/search/search_repository.dart';
import 'package:movie_time/domain/search/search_result.dart';

import 'search_remote_data_source.dart';

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
