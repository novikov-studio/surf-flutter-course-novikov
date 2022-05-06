import 'package:elementary/elementary.dart';
import 'package:places/domain/interactor/settings_interactor.dart';

/// Модель экрана "Онбординг".
class OnboardingScreenModel extends ElementaryModel {
  final SettingsInteractor _settingsInteractor;

  OnboardingScreenModel(
    ErrorHandler errorHandler,
    this._settingsInteractor,
  ) : super(errorHandler: errorHandler);

  Future<void> skipOnStart() async =>
      _settingsInteractor.saveShowTutorialOnStart(value: false);
}
