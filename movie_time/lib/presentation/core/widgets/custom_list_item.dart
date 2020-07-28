import 'package:flutter/material.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';
import 'package:movie_time/presentation/core/widgets/widgets.dart';

class CustomListItem extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String imageUrl;
  final double topTextFontSize;
  final double bottomTextFontSize;
  final double aspectRatio;
  final int maxTopTextLines;

  final Color backgroundColor;
  final Color textColor;

  factory CustomListItem.mobile({
    @required String topText,
    @required String bottomText,
    @required String imageUrl,
    Color backgroundColor,
    Color textColor,
  }) =>
      CustomListItem(
        topText: topText,
        bottomText: bottomText,
        imageUrl: imageUrl,
        aspectRatio: 1 / 2.1,
        topTextFontSize: 14,
        bottomTextFontSize: 11,
        maxTopTextLines: 2,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );

  factory CustomListItem.desktop({
    @required String topText,
    @required String bottomText,
    @required String imageUrl,
  }) =>
      CustomListItem(
        topText: topText,
        bottomText: bottomText,
        imageUrl: imageUrl,
        topTextFontSize: 11,
        bottomTextFontSize: 10,
        aspectRatio: 10 / 18,
        maxTopTextLines: 1,
      );

  const CustomListItem({
    Key key,
    @required this.topText,
    @required this.bottomText,
    @required this.imageUrl,
    @required this.aspectRatio,
    @required this.topTextFontSize,
    @required this.bottomTextFontSize,
    @required this.maxTopTextLines,
    Color backgroundColor,
    Color textColor,
  })  : assert(topText != null && bottomText != null),
        backgroundColor =
            backgroundColor ?? AppColors.defaultCustomListItemBackground,
        textColor = textColor ?? AppColors.defaultCustomListItemText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: PlatformIndependentImage(
                imageUrl: imageUrl,
                errorWidget: NoImageWidget.poster(),
                loadingWidget: LoadingWidget(),
                boxFit: BoxFit.contain,
              ),
            ),
            Text(
              topText,
              maxLines: maxTopTextLines,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.customListItemTop.copyWith(
                fontSize: topTextFontSize,
                color: textColor,
              ),
            ),
            Text(
              bottomText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: bottomTextFontSize,
                color: textColor.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
