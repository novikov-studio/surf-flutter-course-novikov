import 'package:elementary/elementary.dart';
import 'package:places/ui/res/app_scope.dart';

/// Модель Сплэш-скрина.
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel() : super();

  Future<IAppScope> initApp() async {
    final appScope = AppScope();
    await appScope.init();

    return appScope;
  }
}
