import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';

/// WM для Сплэш-скрина.
class SplashScreenWM extends WidgetModel<SplashScreen, SplashScreenModel>
    with CommonWMMixin, SingleTickerProviderWidgetModelMixin
    implements ISplashScreenWidgetModel {
  final _state = EntityStateNotifier<IAppScope>();
  late final AnimationController _animationController;
  late final Animation<double> _rotateAnimation;
  late final Future<void> _animation;

  @override
  ListenableEntityState<IAppScope> get state => _state;

  @override
  Animation<double> get rotateAnimation => _rotateAnimation;

  SplashScreenWM(SplashScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _rotateAnimation = Tween<double>(begin: 3.14 * 2, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Запуск анимации.
    _animation = _animate();

    // Старт инициализации.
    _initApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Инициализация приложения.
  Future<void> _initApp() async {
    _state.loading();
    try {
      final appScope = await model.initApp();
      await _animation;
      _state.content(appScope);
    } on Exception catch (e) {
      _state.error(e);
    }
  }

  /// Запуск анимации
  Future<void> _animate() async {
    for (var i = 0; i < 3; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _animationController.reset();
      await _animationController.forward();
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

/// Интерфейс WM.
abstract class ISplashScreenWidgetModel extends ICommonWidgetModel {
  /// Состояние инициализации приложения.
  ListenableEntityState<IAppScope> get state;

  /// Анимация поворота.
  Animation<double> get rotateAnimation;
}

/// Реализация WM по-умолчанию.
SplashScreenWM defaultSplashScreenWidgetModelFactory(BuildContext _) {
  final model = SplashScreenModel();

  return SplashScreenWM(model);
}
