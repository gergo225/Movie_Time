import 'package:equatable/equatable.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';

const String SERVER_FAILURE_MESSAGE = AppStrings.serverFailureMessage;
const String CONNECTION_FAILURE_MESSAGE = AppStrings.connectionFailureMessage;
const String SEARCH_EMPTY_FAILURE_MESSAGE = AppStrings.searchEmptyFailureMessage;

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  @override
  List get props => [];
}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}

class SearchEmptyFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ConnectionFailure:
        return CONNECTION_FAILURE_MESSAGE;
      case SearchEmptyFailure:
        return SEARCH_EMPTY_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }