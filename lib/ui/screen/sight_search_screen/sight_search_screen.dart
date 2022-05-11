import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/env/env.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen_wm.dart';
import 'package:places/ui/screen/sight_search_screen/widget/search_history.dart';
import 'package:places/ui/screen/sight_search_screen/widget/sight_list_tile.dart';
import 'package:places/ui/widget/elementary/state_notifier_builder_ex.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/simple_app_bar.dart';

/// Экран "Поиск мест" по названию.
///
/// При входе на экран отображается история поиска (если не пустая),
/// она же отображается при очистке поля ввода.
/// Для возврата на предыдущий экран необходимо нажать иконку "Очистить" при пустом поле ввода.
class SightSearchScreen
    extends ElementaryWidget<ISightSearchScreenWidgetModel> {
  const SightSearchScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSightSearchScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISightSearchScreenWidgetModel wm) {
    final appBar = SimpleAppBar(
      title: Env.strings.mainScreenTitle,
      bottom: SearchBar(
        controller: wm.textController,
      ),
    );

    // Нужно, чтобы отцентрировать по вертикали EmptyList
    EdgeInsets shift() => EdgeInsets.only(
          bottom:
              appBar.preferredSize.height + appBar.bottom!.preferredSize.height,
        );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: double.infinity,
        child: EntityStateNotifierBuilderEx<List<Sight>>(
          listenableEntityState: wm.searchState,

          /// История поиска.
          initialBuilder: (_) => SearchHistory(wm: wm),

          /// Идет поиск.
          loadingBuilder: (_, __) => const Loader(),

          /// Ошибка поиска.
          errorBuilder: (_, error, __) => EmptyList(
            icon: AppIcons.error,
            title: AppStrings.error,
            details: error?.humanReadableText ?? AppStrings.unknownError,
            padding: shift(),
          ),

          /// Поиск завершен.
          builder: (context, sights) {
            /// Ничего не найдено.
            if (sights!.isEmpty) {
              return EmptyList(
                icon: AppIcons.searchBig,
                title: AppStrings.nothingFound,
                details: AppStrings.tryAnotherSearch,
                padding: shift(),
              );
            }

            /// Результат.
            return ListView.separated(
              itemCount: sights.length,
              itemBuilder: (_, index) => SightListTile(
                sight: sights[index],
                onTap: () => wm.showDetails(sights[index].id),
              ),
              separatorBuilder: (_, index) => const Divider(
                height: 0.8,
                indent: 88,
                endIndent: 16.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
