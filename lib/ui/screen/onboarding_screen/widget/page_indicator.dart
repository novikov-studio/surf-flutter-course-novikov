import 'package:flutter/material.dart';

/// Индикатор перехода по страницам.
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
      builder: (_, child) {
        final pageIndex = pageController.page?.floor() ?? 0.0;

        return Row(
          children: List.generate(
            pageCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: index == pageIndex || index == pageIndex + 1
                      ? _calcWidth(index, 24, pageController.page ?? 0.0)
                      : 8.0,
                  height: 8.0,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: color,
        ),
      ),
    );
  }

  double _calcWidth(int page, double maxWidth, double offset) {
    final fraction = 1 - (page < offset ? offset - page : page - offset);
    final width = 8 + (maxWidth - 8) * fraction;

    return width;
  }
}
