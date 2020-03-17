import 'package:flutter/widgets.dart';
import '../enums/device_screen_type.dart';

/// Utility function to get device type using a mediaQuery
DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth > 700) {
    return DeviceScreenType.Desktop;
  }
  
  return DeviceScreenType.Mobile;
}