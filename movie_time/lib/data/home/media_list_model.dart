import 'package:flutter/foundation.dart';
import 'package:movie_time/data/home/short_media_info_model.dart';
import 'package:movie_time/domain/home/media_list.dart';

class MediaListModel extends MediaList {
  final String listName;
  final List<ShortMediaInfoModel> mediaList;

  MediaListModel({
    @required this.listName,
    @required this.mediaList,
  }) : super(listName: listName, mediaList: mediaList);

  factory MediaListModel.fromJson(
      Map<String, dynamic> json, String listName, int length) {
    return MediaListModel(
      listName: listName,
      mediaList: List<ShortMediaInfoModel>.from(
        json["results"].take(length).map((mediaJson) {
          return ShortMediaInfoModel.fromJson(mediaJson);
        }),
      ),
    );
  }
}
