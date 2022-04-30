import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_wm.dart';
import 'package:places/ui/screen/filters_screen/widgets/categories_grid.dart';
import 'package:places/ui/screen/filters_screen/widgets/slider_bar.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:provider/provider.dart';

/// Экран "Фильтры".
///
/// Кнопка Очистить задает значение фильтра по-умолчанию.
/// Однако оно используется только при нажатии кнопки ПОКАЗАТЬ.
///
/// Если после нажатия Очистить вернуться на главный экран
/// с помощью программной или аппаратной кнопки Назад
/// филььр будет сброшен.
class FiltersScreen extends ElementaryWidget<IFiltersScreenWidgetModel> {
  const FiltersScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultFiltersScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFiltersScreenWidgetModel wm) {
    return Provider<IFiltersScreenWidgetModel>.value(
      value: wm,
      child: WillPopScope(
        onWillPop: wm.onWilPopup,
        child: Scaffold(
          appBar: SimpleAppBar(
            leadingIcon: AppIcons.arrow,
            leadingOnTap: wm.back,
            trailingText: AppStrings.clear,
            trailingOnTap: wm.clearFilter,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Text(
                  AppStrings.categories,
                  style: wm.theme.superSmallInactiveBlack,
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CategoriesGrid(),
                ),
              ),
              spacerH24,
              DoubleSourceBuilder<double, double>(
                firstSource: wm.minRadius,
                secondSource: wm.maxRadius,
                builder: (_, minRadius, maxRadius) => SliderBar(
                  range: RangeValues(minRadius!, maxRadius!),
                  onChanged: wm.onDistanceChange,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: EntityStateNotifierBuilder<int>(
              listenableEntityState: wm.foundCount,
              loadingBuilder: (_, __) => ElevatedButton(
                // ignore: no-empty-block
                onPressed: () {},
                child: Loader(size: wm.loaderSize),
              ),
              builder: (_, count) => ElevatedButton(
                onPressed: (count ?? 0) > 0 ? wm.applyFilter : null,
                child: Text(
                  AppStrings.showFilterResults(count ?? 0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
