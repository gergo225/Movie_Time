import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:movie_time/data/core/network/network_info.dart';

NetworkInfo getNetworkInfo() => MobileNetworkInfo();

class MobileNetworkInfo implements NetworkInfo {
  final DataConnectionChecker _dataConnectionChecker;

  // Pass in optional instance of the DataConnectionChecker
  // Set local instance to the parameter if it is passed
  MobileNetworkInfo([DataConnectionChecker dataConnectionChecker])
      : _dataConnectionChecker =
            dataConnectionChecker ?? DataConnectionChecker();

  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;
}
