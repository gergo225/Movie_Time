import 'package:flutter/material.dart';
import 'features/movie/presentation/pages/movie_info_page.dart';
import 'features/search/presentation/pages/search_page.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
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
      home: SearchPage(),
    );
  }
}
