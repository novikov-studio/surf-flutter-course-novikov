import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/res/logger.dart';

/// Зависимости приложения.
class AppScope implements IAppScope {
  final ErrorHandler _errorHandler;
  final PlaceInteractor _placeInteractor;
  final SettingsInteractor _settingsInteractor;

  @override
  PlaceInteractor get placeInteractor => _placeInteractor;

  @override
  SettingsInteractor get settingsInteractor => _settingsInteractor;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  const AppScope({
    required PlaceInteractor placeInteractor,
    required SettingsInteractor settingsInteractor,
    required ErrorHandler errorHandler,
  })  : _placeInteractor = placeInteractor,
        _settingsInteractor = settingsInteractor,
        _errorHandler = errorHandler;
}

/// Интерфейс зависимостей приложения.
abstract class IAppScope {
  PlaceInteractor get placeInteractor;

  SettingsInteractor get settingsInteractor;

  ErrorHandler get errorHandler;
}

/// Глобальный обработчик ошибок (для Elementary).
class AppErrorHandler implements ErrorHandler {
  const AppErrorHandler();

  @override
  void handleError(Object error) {
    logError(error);
  }
}
