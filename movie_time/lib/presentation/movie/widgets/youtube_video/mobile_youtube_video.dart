import 'package:flutter/material.dart';
import 'package:movie_time/presentation/movie/widgets/youtube_video/youtube_video.dart';
import 'package:webview_flutter/webview_flutter.dart';

YouTubeVideo getYouTubeVideo(String youTubeVideoKey) =>
    MobileYoutubeVideo(youTubeVideoKey: youTubeVideoKey);

class MobileYoutubeVideo extends StatefulWidget implements YouTubeVideo {
  final String youTubeVideoKey;

  const MobileYoutubeVideo({@required this.youTubeVideoKey});

  @override
  State<StatefulWidget> createState() => _MobileYoutubeVideoState();
}

class _MobileYoutubeVideoState extends State<MobileYoutubeVideo> {
  @override
  Widget build(BuildContext context) {
    String youtubeLink =
        "https://www.youtube.com/embed/${widget.youTubeVideoKey}";

    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: youtubeLink,
    );
  }
}
