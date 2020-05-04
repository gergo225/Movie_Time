
import 'package:flutter/material.dart';

import 'dart:html';
import 'dart:ui' as ui;

import 'package:movie_time/presentation/movie/widgets/youtube_video/youtube_video.dart';

YouTubeVideo getYouTubeVideo(String youTubeVideoKey) =>
    WebYoutubeVideo(youTubeVideoKey: youTubeVideoKey);

class WebYoutubeVideo extends StatefulWidget implements YouTubeVideo {
  final String youTubeVideoKey;

  WebYoutubeVideo({@required this.youTubeVideoKey});

  @override
  _WebYoutubeVideoState createState() => _WebYoutubeVideoState();
}

class _WebYoutubeVideoState extends State<WebYoutubeVideo> {
  @override
  void initState() {
    super.initState();
    String youtubeLink =
        "https://www.youtube.com/embed/${widget.youTubeVideoKey}";

    // ignore: undefined_prefix_name
    ui.platformViewRegistry.registerViewFactory(
      widget.youTubeVideoKey,
      (int viewId) => IFrameElement()
        ..src = youtubeLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.youTubeVideoKey);
  }
}
