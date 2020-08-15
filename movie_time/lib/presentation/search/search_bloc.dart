import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/search/search_media_by_title.dart';
import 'package:movie_time/domain/search/search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMediaByTitle searchMediaByTitle;

  SearchBloc({@required SearchMediaByTitle byTitle})
      : assert(byTitle != null),
        searchMediaByTitle = byTitle,
        super(Empty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchesForTitle) {
      yield Loading();
      final failureOrSearch =
          await searchMediaByTitle(Params(title: event.movieTitle));
      yield failureOrSearch.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (result) => Loaded(searchResult: result),
      );
    }
  }
}
