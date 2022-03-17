import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/darken_image.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/sight_details_text.dart';

/// Экран "Детализация".
class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusHeight = MediaQuery.of(context).viewPadding.top;
    final photos = widget.sight.urls;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: photos.length > 1
                    ? PageView(
                        controller: _controller,
                        children: photos
                            .map((element) => DarkenImage(url: element))
                            .toList(growable: false),
                      )
                    : DarkenImage(url: photos.first),
              ),
              if (photos.length > 1)
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  height: 8.0,
                  child: _PageIndicator(
                    pageController: _controller,
                    pageCount: photos.length,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              Positioned(
                left: 16.0,
                top: statusHeight + 16.0,
                height: 32.0,
                width: 32.0,
                child: ElevatedButton(
                  onPressed: context.popScreen,
                  child: const Icon(Icons.chevron_left),
                  style: theme.btnBack,
                ),
              ),
            ],
          ),
          spacerH24,
          Expanded(
            child: SingleChildScrollView(
              child: SightDetailsText(sight: widget.sight),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Индикатор активной страницы в галерее фото.
class _PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color color;

  const _PageIndicator({
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
