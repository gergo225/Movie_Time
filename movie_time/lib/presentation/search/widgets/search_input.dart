import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/presentation/search/search_bloc.dart';

class SearchInput extends StatefulWidget {
  SearchInput({Key key}) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                hintText: "Search for movies",
              ),
              onChanged: (value) {
                inputStr = value;
              },
              onSubmitted: (_) {
                addSearchByTitle();
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
            onPressed: addSearchByTitle,
          ),
        ],
      ),
    );
  }

  void addSearchByTitle() {
    BlocProvider.of<SearchBloc>(context).add(GetSearchesForTitle(inputStr));
  }
}
