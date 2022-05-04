import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/responsive.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

/// Корневой виджет приложения.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      builder: (context, appScope) {
        return MultiProvider(
          providers: [
            Provider<IAppScope>.value(
              value: appScope!,
            ),
            ChangeNotifierProvider<SettingsInteractor>.value(
              value: appScope.settingsInteractor,
            ),
          ],
          child: const _MaterialApp(),
        );
      },
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
        initialRoute: context.settings.showTutorialOnStart
            ? AppRoutes.onboarding
            : AppRoutes.home,
        routes: AppRoutes.routes,
        builder: (_, child) => Responsive(child: child!),
      ),
    );
  }
}
