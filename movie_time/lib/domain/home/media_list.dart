import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/short_media_info.dart';

class MediaList extends Equatable {
  final String listName;
  final List<ShortMediaInfo> mediaList;

  MediaList({
    @required this.listName,
    @required this.mediaList,
  });

  @override
  List get props => [listName, mediaList];
}
