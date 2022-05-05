import 'package:flutter/material.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details/widget/page_indicator.dart';
import 'package:places/ui/widget/darken_image.dart';

/// Схлопывающаяся галерея фото.
class GalleryDelegate extends SliverPersistentHeaderDelegate {
  final List<String> photos;
  final PageController controller;
  final double maxHeight;
  final bool backButton;
  final Object heroTag;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => 0;

  GalleryDelegate({
    required this.photos,
    required this.controller,
    required this.maxHeight,
    required this.backButton,
    required this.heroTag,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final statusHeight = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        Hero(
          tag: heroTag,
          child: photos.length > 1
              ? PageView(
                  controller: controller,
                  children: photos
                      .map((element) => DarkenImage(url: element))
                      .toList(growable: false),
                )
              : DarkenImage(
                  url: photos.first,
                  size: Size(maxHeight, maxHeight),
                ),
        ),
        if (photos.length > 1)
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            height: 8.0,
            child: PageIndicator(
              pageController: controller,
              pageCount: photos.length,
              color: theme.colorScheme.onBackground,
            ),
          ),
        if (backButton)
          Positioned(
            left: 16.0,
            top: statusHeight + 16.0,
            height: 32.0,
            width: 32.0,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left),
              style: theme.btnBack,
            ),
          ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! GalleryDelegate ||
        minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxHeight ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        photos != oldDelegate.photos ||
        controller != oldDelegate.controller;
  }
}
