import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/search_repository.dart';
import '../entities/search_result.dart';

class SearchMovieByTitle extends UseCase<SearchResult, Params> { 
  final SearchRepository repository;

  SearchMovieByTitle(this.repository);

  @override
  Future<Either<Failure, SearchResult>> call(params) async {
    return await repository.searchMovieByTitle(params.title);
  }
}

class Params extends Equatable {
  final String title;

  Params({@required this.title}) : super([title]);
}