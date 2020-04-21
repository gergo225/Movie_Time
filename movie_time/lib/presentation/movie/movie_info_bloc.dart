import 'dart:async';
import 'package:dartz/dartz.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/movie/get_latest_movie.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/core/input_converter.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be a positive integer";

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  final GetMovieById getMovieById;
  final GetLatestMovie getLatestMovie;
  final InputConverter inputConverter;

  MovieInfoBloc({
    @required GetMovieById byId,
    @required GetLatestMovie latest,
    @required this.inputConverter,
  })  : assert(byId != null),
        assert(latest != null),
        getMovieById = byId,
        getLatestMovie = latest;

  @override
  MovieInfoState get initialState => Empty();

  @override
  Stream<MovieInfoState> mapEventToState(
    MovieInfoEvent event,
  ) async* {
    if (event is GetInfoForMovieById) {
      final inputEither = inputConverter.stringToUnsignedInt(event.idString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrMovie = await getMovieById(Params(id: integer));
          yield* _eitherLoadedOrErrorState(failureOrMovie);
        },
      );
    } else if (event is GetInfoForLatestMovie) {
      yield Loading();
      final failureOrMovie = await getLatestMovie(NoParams());
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