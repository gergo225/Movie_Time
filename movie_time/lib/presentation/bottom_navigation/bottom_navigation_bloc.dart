import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  @override
  BottomNavigationState get initialState => Loading();

  @override
  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is AppStarted) {
      this.add(PageTapped(0));
    }
    if (event is PageTapped) {
      yield PageLoaded(event.index);
    }
  }
}
