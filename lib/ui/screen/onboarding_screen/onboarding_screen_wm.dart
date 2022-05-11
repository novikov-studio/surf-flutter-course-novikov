import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/context_extension.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Онбординг".
class OnboardingScreenWM
    extends WidgetModel<OnboardingScreen, OnboardingScreenModel>
    with CommonWMMixin, SingleTickerProviderWidgetModelMixin
    implements IOnboardingScreenWidgetModel {
  /// Анимация иконок.
  ///
  /// При входе на экран установлен автоматический режим:
  /// [IconAnimationMode.auto] - иконка анимируется в течение заданного времени
  /// на основе данных от [_animationController] и [_iconAnimation].
  ///
  /// После завершения анимации происходит смена режима:
  /// [IconAnimationMode.slide] - иконки анимируются при листании страниц
  /// на основе данных от [_pageController].
  /// При входе на страницу ионка увеличивается, при уходе - уменьшается.
  final _iconAnimationMode =
      StateNotifier<IconAnimationMode>(initValue: IconAnimationMode.auto);
  late final AnimationController _animationController;
  late final Animation<double> _iconAnimation;

  final _pageController = PageController();
  final _skipButtonTransparency = StateNotifier<double>(initValue: 1.0);

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<IconAnimationMode> get iconAnimationMode =>
      _iconAnimationMode;

  @override
  Listenable get iconSizeInterpolator =>
      _iconAnimationMode.equals(IconAnimationMode.auto)
          ? _animationController
          : _pageController;

  @override
  ListenableState<double> get skipButtonTransparency => _skipButtonTransparency;

  OnboardingScreenWM(OnboardingScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pageController.addListener(_pageToTransparency);

    // Контроллер анимации
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _iconAnimationMode.accept(IconAnimationMode.slide);
        }
      });

    // Анимация иконки
    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Запуск анимации
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void start() {
    model.skipOnStart();
    Navigator.of(context).canPop()
        ? Navigator.of(context).pop()
        : context.replaceScreen(AppRoutes.home);
  }

  @override
  double iconSizeInterpolate(int index) {
    return _iconAnimationMode.equals(IconAnimationMode.auto)
        ? _iconAnimation.value
        : _pageController.fraction(index);
  }

  void _pageToTransparency() {
    final page = _pageController.page ?? 0.0;
    final transparency = page >= 2.0
        ? 0.0
        : page > 1.0
            ? 2.0 - page
            : 1.0;
    _skipButtonTransparency.accept(transparency);
  }
}

/// Интерфейс WM.
abstract class IOnboardingScreenWidgetModel extends ICommonWidgetModel {
  /// Контроллер страниц.
  PageController get pageController;

  /// Состояние режима анимации иконок.
  ListenableState<IconAnimationMode> get iconAnimationMode;

  /// Источник анимации иконок.
  Listenable get iconSizeInterpolator;

  /// Состояние прозрачности кнопки "Пропустить".
  ListenableState<double> get skipButtonTransparency;

  /// Интерполятор значений размера иконки.
  double iconSizeInterpolate(int index);

  /// Обработчик нажатия кнопки "Старт".
  void start();
}

/// Реализация WM по-умолчанию.
OnboardingScreenWM defaultOnboardingScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = OnboardingScreenModel(
    appDependencies.errorHandler,
    appDependencies.settingsInteractor,
  );

  return OnboardingScreenWM(model);
}

/// Расширение для [PageController].
extension PageControllerExt on PageController {
  /// Доступность page.
  bool get available => !position.hasPixels || position.hasContentDimensions;

  /// Текущая страница.
  double get effectivePage =>
      available ? page ?? initialPage * 1.0 : initialPage * 1.0;

  /// Индекс текущей страницы (по нижней границе).
  int get pageIndex => effectivePage.floor();

  /// Коэффициент сдвига двух видимых страниц.
  double fraction(int index, [double? hiddenValue]) {
    final offset = effectivePage;
    final currentIndex = pageIndex;

    return index == currentIndex || index == currentIndex + 1
        ? 1 - (index < offset ? offset - index : index - offset)
        : hiddenValue ?? 1.0;
  }
}

enum IconAnimationMode { auto, slide }
