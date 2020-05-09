import 'package:flutter/material.dart';
import 'package:movie_time/domain/movie/movie_info.dart';
import 'package:movie_time/presentation/movie/widgets/movie_display/movie_display_desktop.dart';
import 'package:movie_time/presentation/movie/widgets/movie_display/movie_display_mobile.dart';
import 'package:movie_time/responsive_things/responsive/screen_type_layout.dart';

class MovieDisplay extends StatelessWidget {
  final MovieInfo movieInfo;

  const MovieDisplay({@required this.movieInfo});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MovieDisplayMobile(movieInfo: movieInfo),
      desktop: MovieDisplayDesktop(movieInfo: movieInfo),
    );
  }
}
