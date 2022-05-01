import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

/// Корневой виджет приложения.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final IAppScope _appScope = AppScope();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsInteractor>.value(
          value: _appScope.settingsInteractor,
        ),
        Provider<IAppScope>.value(
          value: _appScope,
        ),
      ],
      child: const _MaterialApp(),
    );
  }
}

/// Material App.
class _MaterialApp extends StatelessWidget {
  const _MaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsInteractor, bool>(
      selector: (_, settings) => settings.isLightTheme,
      builder: (_, isLight, __) => MaterialApp(
        title: AppStrings.appTitle,
        theme: isLight ? Themes.light : Themes.dark,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        locale: const Locale('ru'),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        builder: (_, child) => Responsive(child: child!),
      ),
    );
  }
}
