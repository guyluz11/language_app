import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageAtom extends StatelessWidget {
  const ImageAtom(
    this.name, {
    this.fit,
    this.width,
    this.height,
    this.hero,
    this.url,
  });

  final String name;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String? hero;
  final Uri? url;

  Widget image() {
    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url.toString(),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    return Image.asset(
      name,
      fit: fit,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hero != null) {
      return Hero(
        tag: hero!,
        child: image(),
      );
    }
    return image();
  }
}
