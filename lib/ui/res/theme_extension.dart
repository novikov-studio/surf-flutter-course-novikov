import 'package:flutter/material.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/dark_colors.dart';
import 'package:places/ui/const/light_colors.dart';
import 'package:places/ui/res/themes.dart';
import 'package:provider/provider.dart';

/// Доступ к текстовым стилям и цветам по названиям из дизайн-макета
extension ThemeExtension on ThemeData {
  // ----- Общие стили -----

  TextStyle get titleOnSurface => textTheme.title.copyWith(
        color: colorScheme.onSurface,
      );

  TextStyle get titleOnBackground => textTheme.title.copyWith(
        color: colorScheme.onBackground,
      );

  TextStyle get textOnSurface => textTheme.text.copyWith(
        color: colorScheme.onSurface,
      );

  TextStyle get textInactiveBlack => textTheme.text.copyWith(
        color: colorScheme.inactiveBlack,
      );

  TextStyle get textOnBackground => textTheme.text.copyWith(
        color: colorScheme.onBackground,
      );

  TextStyle get text400OnBackground => textTheme.text.copyWith(
        color: colorScheme.onBackground,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text400Secondary2 => textTheme.text.copyWith(
        color: colorScheme.secondary2,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text400OnSurface => textTheme.text.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text400OnDialog => textTheme.text.copyWith(
        color: colorScheme.onDialog,
        fontWeight: FontWeight.w400,
      );

  TextStyle get smallGreen => textTheme.small.copyWith(
        color: colorScheme.green,
      );

  TextStyle get smallOnSurface => textTheme.small.copyWith(
        color: colorScheme.onSurface,
      );

  TextStyle get smallSecondary2 => textTheme.small.copyWith(
        color: colorScheme.secondary2,
      );

  TextStyle get smallInactiveBlack => textTheme.small.copyWith(
        color: colorScheme.inactiveBlack,
      );

  TextStyle get smallBoldWhite => textTheme.smallBold.copyWith(
        color: colorScheme.white,
      );

  TextStyle get subtitleInactiveBlack => textTheme.subtitle.copyWith(
        color: colorScheme.inactiveBlack,
      );

  TextStyle get buttonWhite => textTheme.button!.copyWith(
        color: colorScheme.white,
      );

  TextStyle get buttonGreen => textTheme.button!.copyWith(
        color: colorScheme.green,
      );

  TextStyle get superSmallInactiveBlack => textTheme.superSmall.copyWith(
        color: colorScheme.inactiveBlack,
      );

  TextStyle get superSmall500White => textTheme.superSmall.copyWith(
        color: colorScheme.white,
        fontWeight: FontWeight.w500,
      );

  // ----- Экран "Детализация" -----

  TextStyle get smallBoldForDetailsType => textTheme.smallBold.copyWith(
        color: colorScheme.isLight
            ? colorScheme.secondary
            : colorScheme.secondary2,
      );

  TextStyle get smallForDetailsInfo => textTheme.small.copyWith(
        color: colorScheme.isLight
            ? colorScheme.secondary
            : colorScheme.secondary2,
      );

  // ----- Экран "Стили кнопок" -----
  ButtonStyle get btnVisited => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? colorScheme.green
              : null,
        ),
      );

  ButtonStyle get btnBack => ElevatedButton.styleFrom(
        primary: colorScheme.background,
        onPrimary: colorScheme.onBackground,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      );

  //
  Gradient get fabGradient => LinearGradient(
        colors: [colorScheme.yellow, colorScheme.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // Кастомные темы
  ThemeData get searchBarTheme =>
      Themes.searchBarTheme(isLight: colorScheme.isLight);
}

extension ColorSchemeExt on ColorScheme {
  bool get isLight => brightness == Brightness.light;

  Color get main => primary;

  Color get secondary2 => secondaryContainer;

  Color get green => isLight ? LightColors.green : DarkColors.green;

  Color get yellow => isLight ? LightColors.yellow : DarkColors.yellow;

  Color get white => isLight ? LightColors.white : DarkColors.white;

  Color get inactiveBlack =>
      isLight ? LightColors.inactiveBlack : DarkColors.inactiveBlack;

  Color get onDialog => isLight ? LightColors.secondary2 : DarkColors.white;
}

extension TextThemeExt on TextTheme {
  TextStyle get largeTitle => headline5!;

  TextStyle get title => headline6!;

  TextStyle get subtitle => subtitle1!;

  TextStyle get text => subtitle2!;

  TextStyle get smallBold => bodyText1!;

  TextStyle get small => bodyText2!;

  TextStyle get superSmall => overline!;

  TextStyle get text400 => text.copyWith(fontWeight: FontWeight.w400);
}

extension ContextExt on BuildContext {
  Future<T?> pushScreen<T extends Object?>(String name, {Object? args}) async {
    // workaround: https://github.com/flutter/flutter/issues/57186
    return await Navigator.of(this).pushNamed(name, arguments: args) as T?;
  }

  void replaceScreen(String name, {Object? args}) {
    Navigator.of(this).pushReplacementNamed(name, arguments: args);
  }

  Future<T?> pushBottomSheet<T extends Object?>(
    String name, {
    Object? args,
  }) async {
    return showModalBottomSheet<T>(
      context: this,
      builder: AppRoutes.routes[name]!,
      routeSettings: RouteSettings(
        name: name,
        arguments: args,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  T? routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T?;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape => !isPortrait;

  SettingsInteractor get settings => read<SettingsInteractor>();
}
