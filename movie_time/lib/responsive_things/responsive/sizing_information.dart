import 'package:flutter/cupertino.dart';
import '../enums/device_screen_type.dart';

/// Class containing basic information about the device screen size and type and the widget's size
class SizingInformation {
  final DeviceScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceType,
    this.screenSize,
    this.localWidgetSize
  });

  @override
  String toString() {
    return "DeviceType: $deviceType \nScreenSize: $screenSize \nLocalWidgetSize: $localWidgetSize";
  }
}