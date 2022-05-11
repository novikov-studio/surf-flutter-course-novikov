import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/geo_permissions_wm_mixin.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/sight_list_wm_mixin.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Список мест".
class SightListScreenWM
    extends WidgetModel<SightListScreen, SightListScreenModel>
    with CommonWMMixin, SightListWMMixin, GeoPermissionsWMMixin
    implements ISightListScreenWidgetModel {
  SightListScreenWM(SightListScreenModel model) : super(model);
}

/// Интерфейс WM.
abstract class ISightListScreenWidgetModel extends ICommonWidgetModel
    with ISightListWidgetModel {}

/// Реализация WM по-умолчанию.
SightListScreenWM defaultSightListScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = SightListScreenModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
    appDependencies.searchInteractor,
    appDependencies.settingsInteractor,
  );

  return SightListScreenWM(model);
}
