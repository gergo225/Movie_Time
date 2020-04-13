import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/image_link_creator.dart';
import '../../domain/entities/movie_info.dart';
import 'loading_widget.dart';

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
          Expanded(
            child: ListView(
              children: [
                Text(
                  "Id: ${movieInfo.id.toString()}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Release date: ${movieInfo.releaseDate}",
                  style: TextStyle(fontSize: 16),
                ),
                Text("Rating: ${movieInfo.rating}"),
                Text(
                  "Runtime: ${movieInfo.runtimeInMinutes} minutes",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  movieInfo.overview,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                buildCachedNetworkImage(movieInfo.posterPath),
                buildCachedNetworkImage(movieInfo.backdropPath),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage buildCachedNetworkImage(String url) => CachedNetworkImage(
        imageUrl: createImageLink(url),
        errorWidget: (context, url, error) => Text(error.toString()),
        placeholder: (context, url) => LoadingWidget(),
      );
}
