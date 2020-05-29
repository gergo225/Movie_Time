part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Loading extends BottomNavigationState {}

class PageLoaded extends BottomNavigationState {
  final int index;

  PageLoaded(this.index);

  @override
  List<Object> get props => [index];
}