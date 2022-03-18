import 'dart:async';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/empty_list.dart';

/// Сплеш-скрин.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Future<void> isInitialized;
  late final Future<void> elapsed;

  @override
  void initState() {
    super.initState();
    isInitialized = _init();

    elapsed = Future<void>.delayed(
      const Duration(seconds: 3),
      () => debugPrint('animation done'),
    );

    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: isInitialized,
      builder: (context, snapshot) {
        // Ошибка
        if (snapshot.hasError) {
          return const EmptyList(
            icon: AppIcons.error,
            title: AppStrings.errorOnInit,
            details: AppStrings.errorOnInitDesc,
          );
        }

        // Ожидание
        final colorScheme = Theme.of(context).colorScheme;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.yellow, colorScheme.green],
              begin: const Alignment(-2, 0.0),
              end: const Alignment(1.0, 0.6),
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
                child: SvgIcon(
                  AppIcons.mapFilled,
                  size: 100.0,
                  color: colorScheme.green,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _init() async {
    // Имитация инициализации
    await Future<void>.delayed(
      const Duration(seconds: 2),
      () => debugPrint('init done'),
    );
  }

  Future<void> _navigateToNext() async {
    // Ожидаем инициализации и анимации
    await Future.wait([isInitialized, elapsed]);

    // Переходим на следующий экран
    if (!mounted) return;
    debugPrint('Переход на следующий экран');
    context.replaceScreen<HomeScreen>((context) => const HomeScreen());
  }
}
