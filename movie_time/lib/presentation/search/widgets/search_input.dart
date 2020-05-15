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
  String inputStr = "";
  String previousInputStr = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
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
        ],
      ),
    );
  }

  void addSearchByTitle(FocusScopeNode focus) {
    if (previousInputStr != inputStr) {
      BlocProvider.of<SearchBloc>(context).add(GetSearchesForTitle(inputStr));
      previousInputStr = inputStr;
    }
    controller.text = inputStr;
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
}
