import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/darken_image.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/holders/sights.dart';
import 'package:places/ui/widget/sight_details_text.dart';

/// Экран "Детализация".
class SightDetails extends StatefulWidget {
  final String id;
  final ScrollController? scrollController;

  const SightDetails({
    Key? key,
    required this.id,
    this.scrollController,
  }) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  final _controller = PageController();
  late Future<Sight> _load;

  @override
  void initState() {
    super.initState();
    _load = Sights.of(context)!.read(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Sight>(
        future: _load,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const EmptyList(
              icon: AppIcons.error,
              title: AppStrings.error,
              details: AppStrings.tryLater,
            );
          }
          if (snapshot.hasData) {
            return _Details(
              sight: snapshot.data!,
              pageController: _controller,
              scrollController: widget.scrollController,
            );
          }

          return const Center(
            child: Loader(large: true),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Детализация места.
class _Details extends StatelessWidget {
  final Sight sight;
  final PageController pageController;
  final ScrollController? scrollController;

  const _Details({
    Key? key,
    required this.sight,
    required this.pageController,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(
          delegate: _GalleryDelegate(
            photos: sight.urls,
            controller: pageController,
            maxHeight: MediaQuery.of(context).size.width,
            backButton: scrollController == null,
          ),
        ),
        SliverToBoxAdapter(
          child: SightDetailsText(sight: sight),
        ),
      ],
    );
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

/// Схлопывающаяся галерея фото.
class _GalleryDelegate extends SliverPersistentHeaderDelegate {
  final List<String> photos;
  final PageController controller;
  final double maxHeight;
  final bool backButton;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => 0;

  _GalleryDelegate({
    required this.photos,
    required this.controller,
    required this.maxHeight,
    required this.backButton,
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
        if (photos.length > 1)
          PageView(
            controller: controller,
            children: photos
                .map((element) => DarkenImage(url: element))
                .toList(growable: false),
          )
        else
          DarkenImage(
            url: photos.first,
            size: Size(maxHeight, maxHeight),
          ),
        if (photos.length > 1)
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            height: 8.0,
            child: _PageIndicator(
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
    return oldDelegate is! _GalleryDelegate ||
        minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxHeight ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        photos != oldDelegate.photos ||
        controller != oldDelegate.controller;
  }
}
