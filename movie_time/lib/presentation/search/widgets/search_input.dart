import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/presentation/search/search_bloc.dart';

class SearchInput extends StatefulWidget {
  SearchInput({Key key}) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                hintText: "Search for movies",
              ),
              onChanged: (value) {
                inputStr = value.trim();
              },
              onSubmitted: (_) {
                addSearchByTitle(FocusScope.of(context));
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          RaisedButton(
            child: Text("Search"),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            onPressed: (() {
              addSearchByTitle(FocusScope.of(context));
            }),
          ),
        ],
      ),
    );
  }

  void addSearchByTitle(FocusScopeNode focus) {
    controller.text = inputStr;
    BlocProvider.of<SearchBloc>(context).add(GetSearchesForTitle(inputStr));
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
}
