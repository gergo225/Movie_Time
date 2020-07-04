import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
      child: Material(
        type: MaterialType.button,
        color: Colors.white54,
        child: BackButton(),
      ),
    );
  }
}
