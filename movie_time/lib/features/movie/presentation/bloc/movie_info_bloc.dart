import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_info.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  @override
  MovieInfoState get initialState => Empty();

  @override
  Stream<MovieInfoState> mapEventToState(
    MovieInfoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
