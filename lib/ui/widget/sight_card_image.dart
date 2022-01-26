import 'package:flutter/material.dart';
import 'package:places/ui/app_styles.dart';
import 'package:places/ui/widget/darken_image.dart';

class SightCardImage extends StatelessWidget {
  final String url;
  final String? category;
  final Widget? icon;

  const SightCardImage({
    Key? key,
    required this.url,
    this.category,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DarkenImage(url: url),
        if (category != null)
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              category!,
              style: smallBoldWhite,
            ),
          ),
        if (icon != null)
          Positioned(
            top: 16.0,
            right: 16.0,
            child: icon!,
          ),
      ],
    );
  }
}
