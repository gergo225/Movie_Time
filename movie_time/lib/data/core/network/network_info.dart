import 'network_info_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'web_network_info.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'mobile_network_info.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  factory NetworkInfo() => getNetworkInfo();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected => getNetworkInfo().isConnected;

}
