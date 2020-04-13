import 'package:equatable/equatable.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CONNECTION_FAILURE_MESSAGE = "Connection Failure";

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const<dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ConnectionFailure:
        return CONNECTION_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }