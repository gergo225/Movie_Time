import 'package:flutter/material.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the mobile edition",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
