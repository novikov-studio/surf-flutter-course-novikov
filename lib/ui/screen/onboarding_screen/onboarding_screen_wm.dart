import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Онбординг".
class OnboardingScreenWM
    extends WidgetModel<OnboardingScreen, OnboardingScreenModel>
    with CommonWMMixin
    implements IOnboardingScreenWidgetModel {
  final _pageController = PageController();
  final _skipButtonTransparency = StateNotifier<double>(initValue: 1.0);

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<double> get skipButtonTransparency => _skipButtonTransparency;

  OnboardingScreenWM(OnboardingScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pageController.addListener(_pageToTransparency);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void start() {
    Navigator.of(context).canPop()
        ? Navigator.of(context).pop()
        : context.replaceScreen(AppRoutes.home);
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

  /// Состояние прозрачности кнопки "Пропустить".
  ListenableState<double> get skipButtonTransparency;

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
  );

  return OnboardingScreenWM(model);
}
