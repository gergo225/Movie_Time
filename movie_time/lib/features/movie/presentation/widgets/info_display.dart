import 'package:flutter/material.dart';
import '../../domain/entities/movie_info.dart';

class InfoDisplay extends StatelessWidget {
  final MovieInfo movieInfo;

  const InfoDisplay({
    Key key,
    this.movieInfo,
  })  : assert(movieInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          // Fixed size, doesn't scroll
          Text(
            movieInfo.title,
            style: TextStyle(fontSize: 32),
          ),
          Text(
            "Id: ${movieInfo.id.toString()}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Release date: ${movieInfo.releaseDate}",
            style: TextStyle(fontSize: 16)
          ),
          // Expanded makes it fill in the remaining space
          Expanded(
            child: Center(
              // Only the movie "overview" part will be scrollable
              child: SingleChildScrollView(
                child: Text(
                  movieInfo.overview,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}