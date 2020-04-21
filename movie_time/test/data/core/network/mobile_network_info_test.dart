import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/network/mobile_network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MobileNetworkInfo networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = MobileNetworkInfo(mockDataConnectionChecker);
  });

  group("is connected", () {
    test(
      "should forward the call to DataConnectionChecker.hasConnection",
      () async {
        // arrange
        final hasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => hasConnectionFuture);
        // act
        // NOTICE: We're not awaiting the result
        final result = networkInfo.isConnected;
        // assert
        verify(mockDataConnectionChecker.hasConnection);
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, hasConnectionFuture);
      },
    );
  });
}