import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformIndependentImage extends StatelessWidget {
  final String imageUrl;
  final Widget errorWidget;
  final Widget loadingWidget;
  final double width;
  final BoxFit boxFit;

  /// Network image class for both web and mobile
  const PlatformIndependentImage({
    Key key,
    @required this.imageUrl,
    @required this.errorWidget,
    @required this.loadingWidget,
    @required this.boxFit,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double nonNullWidth = width ?? double.infinity;

    if (kIsWeb) {
      if (imageUrl == null) {
        return errorWidget;
      } else {
        return Image.network(
          imageUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: loadingWidget,
            );
          },
          fit: boxFit,
          width: nonNullWidth,
        );
      }
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => loadingWidget,
        errorWidget: (context, url, error) => errorWidget,
        fit: boxFit,
        width: nonNullWidth,
      );
    }
  }
}
