import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_wm.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Сплэш-скрин.
class SplashScreen extends ElementaryWidget<ISplashScreenWidgetModel> {
  final AppWidgetBuilder builder;

  const SplashScreen({
    Key? key,
    required this.builder,
    WidgetModelFactory wmFactory = defaultSplashScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISplashScreenWidgetModel wm) {
    return EntityStateNotifierBuilder<IAppScope>(
      listenableEntityState: wm.state,

      /// Данные
      builder: builder,

      /// Ошибка.
      errorBuilder: (_, __, ___) => const EmptyList(
        icon: AppIcons.error,
        title: AppStrings.errorOnInit,
        details: AppStrings.errorOnInitDesc,
      ),

      /// Инициализация.
      loadingBuilder: (_, __) {
        final colorScheme = wm.theme.colorScheme;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.yellow, colorScheme.green],
              begin: const Alignment(-1.28, 0.19),
              end: const Alignment(1.61, -0.19),
            ),
          ),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: AnimatedBuilder(
                  animation: wm.rotateAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: wm.rotateAnimation.value,
                      child: child,
                    );
                  },
                  child: SvgIcon(
                    AppIcons.mapFilled,
                    size: 100.0,
                    color: colorScheme.green,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Билдер дочернего виджета.
typedef AppWidgetBuilder = Widget Function(
  BuildContext context,
  IAppScope? appScope,
);
