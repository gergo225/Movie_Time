import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformIndependentImage extends StatelessWidget {
  final String imageUrl;
  final Widget errorWidget;
  final Widget loadingWidget;
    /// Width of the picture. By default fits the parent
  final double width;
  final BoxFit boxFit;
    /// Alignment of the picture. Default is Alignment.center
  final AlignmentGeometry alignment;

  /// Network image class for both web and mobile
  const PlatformIndependentImage({
    Key key,
    @required this.imageUrl,
    @required this.errorWidget,
    @required this.loadingWidget,
    @required this.boxFit,
    this.width = double.infinity,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
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
          alignment: alignment,
          fit: boxFit,
          width: width,
        );
      }
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => loadingWidget,
        errorWidget: (context, url, error) => errorWidget,
        fit: boxFit,
        width: width,
        alignment: alignment,
      );
    }
  }
}
