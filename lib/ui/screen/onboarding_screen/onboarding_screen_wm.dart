import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_model.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Онбординг".
class OnboardingScreenWM
    extends WidgetModel<OnboardingScreen, OnboardingScreenModel>
    implements IOnboardingScreenWidgetModel {
  final String? _nextScreen;
  final _pageController = PageController();
  final _skipButtonTransparency = StateNotifier<double>(initValue: 1.0);

  @override
  PageController get pageController => _pageController;

  @override
  ThemeData get theme => _theme;

  @override
  ListenableState<double> get skipButtonTransparency => _skipButtonTransparency;

  late ThemeData _theme;

  OnboardingScreenWM(OnboardingScreenModel model, this._nextScreen)
      : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pageController.addListener(_pageToTransparency);
  }

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void start() {
    _nextScreen != null
        ? context.replaceScreen(_nextScreen!)
        : Navigator.of(context).pop();
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
abstract class IOnboardingScreenWidgetModel extends IWidgetModel {
  /// Ссылка на текущую тему.
  ThemeData get theme;

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

  final nextScreen = context.routeArgs<String>();

  final model = OnboardingScreenModel(
    appDependencies.errorHandler,
  );

  return OnboardingScreenWM(model, nextScreen);
}
