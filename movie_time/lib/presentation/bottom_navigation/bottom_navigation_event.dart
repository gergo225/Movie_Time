part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends BottomNavigationEvent {}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped(this.index);

  @override
  List<Object> get props => [index];
}
