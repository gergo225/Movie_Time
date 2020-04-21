import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movie_time/presentation/movie/movie_info_page.dart';
import 'package:movie_time/presentation/search/search_page.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Time',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: MovieInfoPage(),
    );
  }
}
