/// Responsive widget
import 'package:flutter/cupertino.dart';
import 'sizing_information.dart';
import '../utils/ui_utils.dart';

/// Class for widgets that need to be built responsively
class ResponsiveBuilder extends StatelessWidget {
  /// Builder function based on what a responsive widget will be built
  final Function(BuildContext context, SizingInformation sizingInformation) builder;
  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder (builder: (context, boxSizing) {
      var sizingInformation = SizingInformation(
        deviceType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
      );
      
      return builder(context, sizingInformation);
    },);
  }
}