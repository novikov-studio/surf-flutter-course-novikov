import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/logger.dart';
import 'package:places/ui/res/scaffold_messenger_extension.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/mixin/sight_wm_mixin.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_model.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_wm.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:provider/provider.dart';

/// WM виджета "Карточка места".
class SightCardWM extends WidgetModel<SightCard, SightCardModel>
    with SightWMMixin, CommonWMMixin
    implements ISightCardWidgetModel {
  final StateNotifier<Sight> _sightState;
  final CardMode _mode;

  @override
  ListenableState<Sight> get sightState => _sightState;

  @override
  CardMode get mode => _mode;

  @override
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  SightCardWM(SightCardModel model, Sight sight, this._mode)
      : _sightState = StateNotifier<Sight>(initValue: sight),
        super(model);

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  Future<void> toggleInFavorites() async =>
      internalToggleInFavorites(_sightState, model);

  @override
  Future<void> planVisiting() async => internalPlanVisiting(_sightState, model);

  @override
  Future<void> showDetails() async {
    final visitingWM = context.read<IVisitingScreenWidgetModel?>();

    final sight = _sightState.value!;

    // Показываем экран детализации
    await context.pushBottomSheet(AppRoutes.details, args: sight.id);

    // Обновляем текуший экран, если требуется.
    try {
      final newSight = await model.load(sight.id);
      if (newSight != sight) {
        visitingWM != null && !newSight.isLiked
            ? visitingWM.load()
            : _sightState.accept(newSight);
      }
    } on Object catch (e) {
      onErrorHandle(e);
    }
  }
}

/// Инфтервейс WM.
abstract class ISightCardWidgetModel extends ICommonWidgetModel {
  /// Состояние карточки.
  ListenableState<Sight> get sightState;

  /// Режим построения карточки.
  CardMode get mode;

  /// Данные о параметрах экрана.
  MediaQueryData get mediaQuery;

  /// Инверсия флага "В избранном".
  Future<void> toggleInFavorites();

  /// Запланировать посещение.
  Future<void> planVisiting();

  /// Показать экран "Детализация".
  Future<void> showDetails();
}

/// Фабрика WM по-умолчанию.
SightCardWM defaultSightCardWidgetModelFactory(
  BuildContext context,
  Sight sight,
  CardMode mode,
) {
  final appDependencies = context.read<IAppScope>();

  final model = SightCardModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
  );

  return SightCardWM(model, sight, mode);
}
