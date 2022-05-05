import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details/sight_details_wm.dart';
import 'package:places/ui/screen/sight_details/widget/card_menu.dart';
import 'package:places/ui/screen/sight_details/widget/gallery_delegate.dart';
import 'package:places/ui/screen/sight_details/widget/go_route_button.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:places/ui/widget/spacers.dart';
import 'package:provider/provider.dart';

/// Экран "Детализация".
class SightDetails extends ElementaryWidget<ISightDetailsWidgetModel> {
  final ScrollController? scrollController;

  const SightDetails({
    Key? key,
    this.scrollController,
    WidgetModelFactory wmFactory = defaultSightDetailsWMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISightDetailsWidgetModel wm) {
    final theme = wm.theme;

    return Scaffold(
      body: EntityStateNotifierBuilder<ListenableState<Sight>>(
        listenableEntityState: wm.sightLoadingState,

        /// Загрузка.
        loadingBuilder: (_, __) => const Center(
          child: Loader(large: true),
        ),

        /// Ошибка.
        errorBuilder: (_, e, __) => EmptyList(
          icon: AppIcons.error,
          title: AppStrings.error,
          details: e?.humanReadableText ?? AppStrings.unknownError,
        ),

        /// Данные.
        builder: (_, sightState) {
          final sight = sightState!.value!;

          return Provider<ISightDetailsWidgetModel>.value(
            value: wm,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  delegate: GalleryDelegate(
                    photos: sight.urls,
                    controller: wm.pageController,
                    maxHeight: wm.screenWidth,
                    backButton: scrollController == null,
                    heroTag: sight.id,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        spacerH24,
                        Text(
                          sight.name,
                          style: theme.titleOnSurface,
                        ),
                        Wrap(
                          children: [
                            Text(
                              sight.type.title,
                              style: theme.smallBoldForDetailsType,
                            ),
                            if (sight.info != null)
                              Text(sight.info!, style: theme.smallForDetailsInfo),
                          ],
                          spacing: 16.0,
                        ),
                        if (sight.details != null) ...[
                          spacerH24,
                          Text(
                            sight.details!.trimRight(),
                            style: theme.smallOnSurface,
                          ),
                        ],
                        spacerH24,
                        GoRouteButton(sight: sight),
                        spacerH24,
                        const Divider(),
                        spacerH8,
                        const CardMenu(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
