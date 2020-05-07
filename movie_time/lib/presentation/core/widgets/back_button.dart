import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
        color: Colors.white54,
      ),
      child: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
