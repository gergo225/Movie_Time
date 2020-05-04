import 'package:flutter/material.dart';
import 'package:movie_time/presentation/movie/widgets/youtube_video/youtube_video_stub.dart'
    if (dart.library.html) 'package:movie_time/presentation/movie/widgets/youtube_video/web_youtube_video.dart'
    if (dart.library.io) 'package:movie_time/presentation/movie/widgets/youtube_video/mobile_youtube_video.dart';

abstract class YouTubeVideo extends Widget {
  factory YouTubeVideo(String youTubeVideoKey) => getYouTubeVideo(youTubeVideoKey);
}
