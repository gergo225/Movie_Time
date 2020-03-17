import 'package:flutter/material.dart';

class HomeViewDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "This is a desktop view",
            style: TextStyle(fontSize: 36),
          ),
      ),
      backgroundColor: Colors.red,
    );
  }
}
