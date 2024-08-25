import 'package:flutter/cupertino.dart';
import 'package:news_feed/common/asset_path.dart';

class NetworkImageView extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double? containerWidth;
  final double? containerHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  const NetworkImageView({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.containerWidth,
    this.containerHeight,
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    String placeholderAsset = AssetPath.placeholderImage;
    return Container(
      margin: margin,
      padding: padding,
      width: containerWidth,
      height: containerHeight,
      decoration: decoration,
      child: FadeInImage.assetNetwork(
        height: height,
        width: width,
        placeholder: placeholderAsset,
        image: imageUrl ?? "https://picsum.photos/300/200", // default url to fetch random network image since api response has no image
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            placeholderAsset,
            fit: BoxFit.cover,
          );
        },
        fit: BoxFit.cover, // Adjust as needed
      ),
    );
  }
}
