import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/features/movie/presentation/bloc/movie_info_bloc.dart';

class InfoControls extends StatefulWidget {
  const InfoControls({Key key}) : super(key: key);

  @override
  _InfoControlsState createState() => _InfoControlsState();
}

class _InfoControlsState extends State<InfoControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Input an id number",
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            addById();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                child: Text("Search"),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: addById,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text("Get latest movie"),
                onPressed: addLatest,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addById() {
    // Clearing the text field to prepare it for the next number
    controller.clear();
    BlocProvider.of<MovieInfoBloc>(context).add(GetInfoForMovieById(inputStr));
  }

  void addLatest() {
    controller.clear();
    BlocProvider.of<MovieInfoBloc>(context).add(GetInfoForLatestMovie());
  }
}
