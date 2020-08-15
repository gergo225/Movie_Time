import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'search_repository.dart';
import 'search_result.dart';

class SearchMediaByTitle extends UseCase<SearchResult, Params> { 
  final SearchRepository repository;

  SearchMediaByTitle(this.repository);

  @override
  Future<Either<Failure, SearchResult>> call(params) async {
    if (params.title.trim().isEmpty) {
      return Left(SearchEmptyFailure());
    }
    return await repository.searchMediaByTitle(params.title);
  }
}

class Params extends Equatable {
  final String title;

  Params({@required this.title});

  @override
  List get props => [title];
}