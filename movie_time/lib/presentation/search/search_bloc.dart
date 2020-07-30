import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/search/search_movie_by_title.dart';
import 'package:movie_time/domain/search/search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovieByTitle searchMovieByTitle;

  SearchBloc({@required SearchMovieByTitle byTitle})
      : assert(byTitle != null),
        searchMovieByTitle = byTitle,
        super(Empty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchesForTitle) {
      yield Loading();
      final failureOrSearch =
          await searchMovieByTitle(Params(title: event.movieTitle));
      yield failureOrSearch.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (result) => Loaded(searchResult: result),
      );
    }
  }
}
