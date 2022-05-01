import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';

/// WM для Сплэш-скрина.
class SplashScreenWM extends WidgetModel<SplashScreen, SplashScreenModel>
    with CommonWMMixin<SplashScreen, SplashScreenModel>
    implements ISplashScreenWidgetModel {
  late final Future<void> animation;
  final _state = EntityStateNotifier<IAppScope>();

  @override
  ListenableEntityState<IAppScope> get state => _state;

  SplashScreenWM(SplashScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    // Запуск анимации.
    animation = Future<void>.delayed(
      const Duration(seconds: 3),
      () => debugPrint('animation done'),
    );

    // Старт инициализации.
    _initApp();
  }

  /// Инициализация приложения.
  Future<void> _initApp() async {
    _state.loading();
    try {
      final appScope = await model.initApp();
      await animation;
      _state.content(appScope);
    } on Exception catch (e) {
      _state.error(e);
    }
  }
}

/// Интерфейс WM.
abstract class ISplashScreenWidgetModel extends ICommonWidgetModel {
  /// Состояние инициализации приложения.
  ListenableEntityState<IAppScope> get state;
}

/// Реализация WM по-умолчанию.
SplashScreenWM defaultSplashScreenWidgetModelFactory(BuildContext _) {
  final model = SplashScreenModel();

  return SplashScreenWM(model);
}
