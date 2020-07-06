import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_strings.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';
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
      height: 48,
      child: Row(
        children: <Widget>[
          CustomBackButton(),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                filled: true,
                fillColor: AppColors.searchBarFill,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: EdgeInsets.only(left: 12),
              ),
              onChanged: (value) {
                inputStr = value.trim();
              },
              onSubmitted: (_) {
                addSearchByTitle(FocusScope.of(context));
              },
            ),
          ),
          SizedBox(width: 8),
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
