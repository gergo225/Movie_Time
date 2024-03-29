import 'package:flutter/material.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';

class NoImageWidget extends StatelessWidget {
  final double aspectRatio;

  NoImageWidget({Key key, @required this.aspectRatio})
      : assert(aspectRatio != null),
        super(key: key);

  /// Widget with 2/3 aspect ratio
  /// Fits for posters and profile images
  factory NoImageWidget.poster() {
    return NoImageWidget(aspectRatio: 2 / 3);
  }

  /// Widget with 16/9 aspect ratio
  /// Fits for backdrops
  factory NoImageWidget.wide() {
    return NoImageWidget(aspectRatio: 16 / 9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Center(
          child: Text(
            AppStrings.noImage,
            style: AppTextStyles.noImage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
