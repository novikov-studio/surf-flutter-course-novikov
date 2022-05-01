import 'package:flutter/material.dart';

/// Индикатор активной страницы в галерее фото.
class PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color color;

  const PageIndicator({
    Key? key,
    required this.pageController,
    required this.pageCount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (_, child) => FractionallySizedBox(
        alignment: Alignment.bottomLeft,
        widthFactor: ((pageController.page ?? 0) + 1) / pageCount,
        child: child,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius:
          const BorderRadius.horizontal(right: Radius.circular(8.0)),
          color: color,
        ),
      ),
    );
  }
}
