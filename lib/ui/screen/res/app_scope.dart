import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/screen/res/logger.dart';

/// Зависимости приложения.
class AppScope implements IAppScope {
  final ErrorHandler _errorHandler;
  final PlaceInteractor _placeInteractor;

  @override
  PlaceInteractor get placeInteractor => _placeInteractor;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  const AppScope({
    required PlaceInteractor placeInteractor,
    required ErrorHandler errorHandler,
  })  : _placeInteractor = placeInteractor,
        _errorHandler = errorHandler;
}

/// Интерфейс зависимостей приложения.
abstract class IAppScope {
  PlaceInteractor get placeInteractor;

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
