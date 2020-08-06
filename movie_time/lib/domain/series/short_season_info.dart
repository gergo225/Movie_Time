import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ShortSeasonInfo extends Equatable {
  final String name;
  final String posterPath;

  ShortSeasonInfo({
    @required this.name,
    @required this.posterPath,
  });

  @override
  List<Object> get props => [name, posterPath];
}
