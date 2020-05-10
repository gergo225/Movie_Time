import 'package:flutter/widgets.dart';
import '../enums/device_screen_type.dart';

/// Utility function to get device type using a mediaQuery
DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;

  bool isDesktopSize = mediaQuery.size.height > 768 &&
      mediaQuery.orientation == Orientation.landscape;

  if (deviceWidth > 992 || isDesktopSize) {
    return DeviceScreenType.Desktop;
  }

  return DeviceScreenType.Mobile;
}
