import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeInfo getHomeInfo;

  HomeBloc({@required this.getHomeInfo}) : assert(getHomeInfo != null);

  @override
  HomeState get initialState => Empty();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetInfoForHome) {
      yield Loading();
      final failureOrHome = await getHomeInfo(NoParams());
      yield failureOrHome.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (homeInfo) => Loaded(homeInfo: homeInfo),
      );
    }
  }
}
