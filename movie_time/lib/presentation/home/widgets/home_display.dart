import 'package:flutter/material.dart';
import 'package:movie_time/domain/home/home_info.dart';

class HomeDisplay extends StatelessWidget {
  final HomeInfo homeInfo;

  const HomeDisplay({Key key, @required this.homeInfo})
      : assert(homeInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement home display UI
    return Container();
  }
}
