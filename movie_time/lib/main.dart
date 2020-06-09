import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/injection_container.dart';
import 'package:movie_time/presentation/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:movie_time/presentation/home/home_info_page.dart';
import 'package:movie_time/presentation/search/search_page.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  di.init();
  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Movie Time',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: BlocProvider<BottomNavigationBloc>(
        create: (_) => sl<BottomNavigationBloc>()..add(AppStarted()),
        child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            if (state is PageLoaded) {
              return Scaffold(
                body: SafeArea(
                  child: IndexedStack(
                    index: state.index,
                    children: [
                      HomeInfoPage(),
                      SearchPage(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text("")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), title: Text("")),
                  ],
                  onTap: (value) {
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add(PageTapped(value));
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
