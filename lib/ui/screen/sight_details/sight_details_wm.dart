import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/logger.dart';
import 'package:places/ui/screen/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/mixins/sight_wm_mixin.dart';
import 'package:places/ui/screen/sight_details/sight_details.dart';
import 'package:places/ui/screen/sight_details/sight_details_model.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Детализация".
class SightDetailsWM extends WidgetModel<SightDetails, SightDetailsModel>
    with SightWMMixin<SightDetails, SightDetailsModel>
    implements ISightDetailsWidgetModel {
  final int _sightId;
  final _pageController = PageController();
  final _sightState = EntityStateNotifier<StateNotifier<Sight>>();

  @override
  PageController get pageController => _pageController;

  @override
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  ListenableEntityState<ListenableState<Sight>> get sightLoadingState =>
      _sightState;

  @override
  ListenableState<Sight> get sightState => _sightState.value!.data!;

  @override
  ThemeData get theme => _theme;

  late ThemeData _theme;

  SightDetailsWM(SightDetailsModel model, this._sightId) : super(model);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadSight();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  Future<void> toggleInFavorites() async =>
      internalToggleInFavorites(_sightState.value!.data!, model);

  @override
  Future<void> planVisiting() async =>
      internalPlanVisiting(_sightState.value!.data!, model);

  Future<void> _loadSight({bool silent = false}) async {
    if (!silent) {
      _sightState.loading();
    }
    try {
      final sight = await model.load(_sightId);
      _sightState.content(StateNotifier<Sight>(initValue: sight));
    } on Exception catch (e) {
      _sightState.error(e);
    }
  }
}

/// Интерфейс WM.
abstract class ISightDetailsWidgetModel extends IWidgetModel {
  /// Контроллер галереи фото.
  PageController get pageController;

  /// Ширина экрана устройства.
  double get screenWidth;

  /// Текущая тема.
  ThemeData get theme;

  /// Состояние загрузки [Sight].
  ListenableEntityState<ListenableState<Sight>> get sightLoadingState;

  /// Состояние [Sight].
  ListenableState<Sight> get sightState;

  /// Инверсия флага "В избранном".
  Future<void> toggleInFavorites();

  /// Запланировать посещение.
  Future<void> planVisiting();
}

/// Реализация WM по-умолчанию.
SightDetailsWM defaultSightDetailsWMFactory(BuildContext context) {
  final appDependencies = context.read<IAppScope>();

  final sightId = context.routeArgs<int>();

  final model = SightDetailsModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
  );

  return SightDetailsWM(model, sightId!);
}
