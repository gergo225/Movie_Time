import 'dart:async';
import 'package:dartz/dartz.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  final GetMovieById getMovieById;

  MovieInfoBloc({
    @required GetMovieById byId,
  })  : assert(byId != null),
        getMovieById = byId,
        super(Loading());

  @override
  Stream<MovieInfoState> mapEventToState(
    MovieInfoEvent event,
  ) async* {
    if (event is GetInfoForMovieById) {
      final failureOrMovie = await getMovieById(Params(id: event.movieId));
      yield* _eitherLoadedOrErrorState(failureOrMovie);
    }
  }

  Stream<MovieInfoState> _eitherLoadedOrErrorState(
    Either<Failure, MovieInfo> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: mapFailureToMessage(failure)),
      (movie) => Loaded(movie: movie),
    );
  }
}
