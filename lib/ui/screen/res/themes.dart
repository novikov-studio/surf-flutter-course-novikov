import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/const/app_styles.dart';
import 'package:places/ui/const/dark_colors.dart';
import 'package:places/ui/const/light_colors.dart';

abstract class Themes {
  static ThemeData get light => ThemeData.from(
        colorScheme: _buildColorScheme(isLight: true),
        textTheme: _buildTextTheme(),
      ).copyWith(
        appBarTheme: _buildAppBarTheme(
          isLight: true,
          background: LightColors.background,
          foreground: LightColors.main,
        ),
        tabBarTheme: _buildTabBarTheme(
          tabBackground: LightColors.secondary,
          labelColor: LightColors.white,
          unselectedLabelColor: LightColors.inactiveBlack,
        ),
        cardTheme: _buildCardTheme(),
        dividerColor: LightColors.divider,
        dividerTheme: _buildDividerThemeData(color: LightColors.divider),
        bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
          background: LightColors.background,
          foreground: DarkColors.secondary,
        ),
      );

  static ThemeData get dark => ThemeData.from(
        colorScheme: _buildColorScheme(isLight: false),
        textTheme: _buildTextTheme(),
      ).copyWith(
        appBarTheme: _buildAppBarTheme(
          isLight: false,
          background: DarkColors.background,
          foreground: DarkColors.white,
        ),
        tabBarTheme: _buildTabBarTheme(
          tabBackground: DarkColors.white,
          labelColor: DarkColors.secondary,
          unselectedLabelColor: DarkColors.secondary2,
        ),
        cardTheme: _buildCardTheme(),
        dividerColor: DarkColors.divider,
        dividerTheme: _buildDividerThemeData(color: DarkColors.divider),
        bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
          background: DarkColors.background,
          foreground: DarkColors.white,
        ),
      );

  static AppBarTheme _buildAppBarTheme({
    required bool isLight,
    required Color background,
    required Color foreground,
  }) =>
      AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        titleTextStyle: subtitle.copyWith(color: foreground),
        elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: background,
          systemNavigationBarDividerColor: background,
          systemNavigationBarIconBrightness:
              isLight ? Brightness.dark : Brightness.light,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
          statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
        ),
        //systemOverlayStyle: SystemUiOverlayStyle.light,
      );

  static TabBarTheme _buildTabBarTheme({
    required Color tabBackground,
    required Color labelColor,
    required Color unselectedLabelColor,
  }) =>
      TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          color: tabBackground,
        ),
        labelPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: smallBold,
        unselectedLabelStyle: smallBold,
      );

  static CardTheme _buildCardTheme() => const CardTheme(
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
            bottom: Radius.circular(12.0),
          ),
        ),
      );

  static TextTheme _buildTextTheme() => const TextTheme(
        headline5: largeTitle,
        headline6: title,
        subtitle1: subtitle,
        subtitle2: text,
        bodyText1: smallBold,
        bodyText2: small,
        button: button,
        overline: superSmall,
      ).apply(fontFamily: 'Roboto');

  static ColorScheme _buildColorScheme({
    required bool isLight,
  }) =>
      ColorScheme(
        brightness: isLight ? Brightness.light : Brightness.dark,
        primary: isLight ? LightColors.main : DarkColors.main,
        secondary: isLight ? LightColors.secondary : DarkColors.secondary,
        secondaryContainer:
            isLight ? LightColors.secondary2 : DarkColors.secondary2,
        background: isLight ? LightColors.background : DarkColors.background,
        surface:
            isLight ? LightColors.cardBackground : DarkColors.cardBackground,
        error: isLight ? LightColors.error : DarkColors.error,
        onPrimary: const Color(0xFFFF00FF),
        onSecondary: const Color(0xFFFF00FF),
        onBackground: isLight ? LightColors.main: DarkColors.white,
        onSurface: isLight ? LightColors.secondary : DarkColors.white,
        onError: const Color(0xFFFF00FF),
      );

  static DividerThemeData _buildDividerThemeData({required Color color}) =>
      DividerThemeData(
        color: color,
        thickness: 0.8,
      );

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme({
    required Color background,
    required Color foreground,
  }) =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: background,
        selectedItemColor: foreground,
        unselectedItemColor: foreground,
      );
}
