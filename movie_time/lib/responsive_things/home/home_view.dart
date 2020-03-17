import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../responsive/screen_type_layout.dart';
import 'home_view_desktop.dart';
import 'home_view_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeViewMobile(),
      desktop: HomeViewDesktop(),
    );
  }
}
