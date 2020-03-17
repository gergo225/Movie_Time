import 'package:flutter/material.dart';
import '../enums/device_screen_type.dart';
import 'responsive_builder.dart';

/// Class that provides separate widgets based on screen type
class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by deafult
  final Widget mobile;
  final Widget desktop;

  const ScreenTypeLayout(
      {Key key, @required this.mobile, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceType == DeviceScreenType.Desktop) {
          if (desktop != null) return desktop;
        }

        return mobile;
      },
    );
  }
}
