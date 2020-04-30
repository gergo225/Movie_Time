import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  final double aspectRatio;

  NoImageWidget({Key key, @required this.aspectRatio})
      : assert(aspectRatio != null),
        super(key: key);

  /// Widget with 2/3 aspect ratio
  factory NoImageWidget.poster() {
    return NoImageWidget(aspectRatio: 2 / 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Center(
          child: Text(
            "No image found",
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
