import 'network_info.dart';
import 'dart:html' as html;

NetworkInfo getNetworkInfo() => WebNetworkInfo();

class WebNetworkInfo implements NetworkInfo {
  @override
  Future<bool> get isConnected => Future.value(html.window.navigator.onLine);
}