import 'package:flutter/material.dart';
import 'package:places/ui/const/dark_colors.dart';
import 'package:places/ui/const/light_colors.dart';

/// Доступ к текстовым стилям и цветам по названиям из дизайн-макета
extension ThemeExtension on ThemeData {
  // TODO(novikov): убрать после перехода на SliverAppBar
  TextStyle get largeTitleForAppBar => textTheme.largeTitle.copyWith(
        color: appBarTheme.foregroundColor,
      );

  // ----- Общие стили -----

  TextStyle get titleOnSurface => textTheme.title.copyWith(
        color: colorScheme.onSurface,
      );

  TextStyle get textOnSurface => textTheme.text.copyWith(
        color: colorScheme.onSurface,
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
}

extension TextThemeExt on TextTheme {
  TextStyle get largeTitle => headline5!;

  TextStyle get title => headline6!;

  TextStyle get subtitle => subtitle1!;

  TextStyle get text => subtitle2!;

  TextStyle get smallBold => bodyText1!;

  TextStyle get small => bodyText2!;

  TextStyle get superSmall => overline!;
}
