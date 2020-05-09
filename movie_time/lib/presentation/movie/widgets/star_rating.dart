import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;

  StarRating({@required this.rating, @required this.starSize})
      : assert(rating >= 0 && rating <= 10);

  @override
  Widget build(BuildContext context) {
    final starsCount = 5;
    List<Widget> starsList = [];

    Widget makeStar(int index) {
      IconData icon = Icons.star_border;
      var fullStars = (rating ~/ 2);

      if (index + 1 <= fullStars) {
        icon = Icons.star;
      } else if (index < fullStars + 1) {
        icon = Icons.star_half;
      }
      return Icon(
        icon,
        size: starSize,
        color: Colors.yellow,
      );
    }

    for (int i = 0; i < starsCount; i++) {
      starsList.add(makeStar(i));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starsList,
    );
  }
}
