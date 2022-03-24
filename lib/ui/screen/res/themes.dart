import 'package:flutter/material.dart';
import 'package:places/ui/const/app_styles.dart';
import 'package:places/ui/const/dark_colors.dart';
import 'package:places/ui/const/light_colors.dart';

abstract class Themes {
  /// Светлая тема.
  static ThemeData get light => ThemeData.from(
        colorScheme: _buildColorScheme(isLight: true),
        textTheme: _buildTextTheme(),
      ).copyWith(
        appBarTheme: _buildAppBarTheme(
          background: LightColors.background,
          title: LightColors.main,
          leading: LightColors.secondary2,
          trailing: LightColors.green,
        ),
        tabBarTheme: _buildTabBarTheme(
          tabBackground: LightColors.secondary,
          labelColor: LightColors.white,
          unselectedLabelColor: LightColors.inactiveBlack,
        ),
        cardTheme: _buildCardTheme(),
        iconTheme: _buildIconTheme(color: LightColors.white),
        elevatedButtonTheme: _buildElevatedButtonThemeData(isLight: true),
        textButtonTheme: _buildTextButtonThemeData(
          active: LightColors.secondary,
          inactive: LightColors.inactiveBlack,
        ),
        sliderTheme: _buildSliderThemeData(
          active: LightColors.green,
          inactive: LightColors.inactiveBlack,
          thumb: LightColors.white,
        ),
        inputDecorationTheme: _buildInputDecorationTheme(isLight: true),
        textSelectionTheme:
            _buildTextSelectionThemeData(color: LightColors.green),
        listTileTheme: _buildListTileThemeData(color: LightColors.main),
        dividerColor: LightColors.inactiveBlack.withOpacity(0.24),
        dividerTheme: _buildDividerThemeData(
          color: LightColors.inactiveBlack.withOpacity(0.24),
        ),
        bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
          background: LightColors.background,
          foreground: DarkColors.secondary,
        ),
      );

  /// Темная тема.
  static ThemeData get dark => ThemeData.from(
        colorScheme: _buildColorScheme(isLight: false),
        textTheme: _buildTextTheme(),
      ).copyWith(
        appBarTheme: _buildAppBarTheme(
          background: DarkColors.background,
          title: DarkColors.white,
          leading: DarkColors.secondary2,
          trailing: DarkColors.green,
        ),
        tabBarTheme: _buildTabBarTheme(
          tabBackground: DarkColors.white,
          labelColor: DarkColors.secondary,
          unselectedLabelColor: DarkColors.secondary2,
        ),
        cardTheme: _buildCardTheme(),
        iconTheme: _buildIconTheme(color: DarkColors.white),
        elevatedButtonTheme: _buildElevatedButtonThemeData(isLight: false),
        textButtonTheme: _buildTextButtonThemeData(
          active: DarkColors.white,
          inactive: DarkColors.inactiveBlack,
        ),
        sliderTheme: _buildSliderThemeData(
          active: DarkColors.green,
          inactive: DarkColors.inactiveBlack,
          thumb: DarkColors.white,
        ),
        inputDecorationTheme: _buildInputDecorationTheme(isLight: false),
        textSelectionTheme:
            _buildTextSelectionThemeData(color: DarkColors.green),
        listTileTheme: _buildListTileThemeData(color: DarkColors.white),
        dividerColor: DarkColors.inactiveBlack.withOpacity(0.24),
        dividerTheme: _buildDividerThemeData(
          color: DarkColors.inactiveBlack.withOpacity(0.24),
        ),
        bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
          background: DarkColors.background,
          foreground: DarkColors.white,
        ),
      );

  /// Тема для строки поиска SearchBar.
  static ThemeData searchBarTheme({required bool isLight}) {
    final inactiveBlack =
        isLight ? LightColors.inactiveBlack : DarkColors.inactiveBlack;
    final surface =
        isLight ? LightColors.cardBackground : DarkColors.cardBackground;

    final onSurface = isLight ? LightColors.secondary2 : DarkColors.white;

    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surface,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        hintStyle:
            text.copyWith(color: inactiveBlack, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: inactiveBlack,
        suffixIconColor: onSurface,
      ),
      textSelectionTheme: _buildTextSelectionThemeData(color: onSurface),
    );
  }

  /// AppBar.
  static AppBarTheme _buildAppBarTheme({
    required Color background,
    required Color title,
    required Color leading,
    required Color trailing,
  }) =>
      AppBarTheme(
        backgroundColor: background,
        foregroundColor: title,
        titleTextStyle: subtitle.copyWith(color: title),
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: leading,
        ),
        actionsIconTheme: IconThemeData(
          color: trailing,
        ),
      );

  /// TabBar.
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

  /// Card.
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

  /// Icon.
  static IconThemeData _buildIconTheme({required Color color}) => IconThemeData(
        color: color,
        size: 24.0,
      );

  /// ElevatedButton.
  static ElevatedButtonThemeData _buildElevatedButtonThemeData({
    required bool isLight,
  }) {
    final background = isLight ? LightColors.green : DarkColors.green;
    final foreground = isLight ? LightColors.white : DarkColors.white;
    final disabledBackground =
        isLight ? LightColors.cardBackground : DarkColors.cardBackground;
    final disabledForeground =
        isLight ? LightColors.inactiveBlack : DarkColors.inactiveBlack;

    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: background,
        onPrimary: foreground,
        textStyle: button,
        padding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        minimumSize: Size.zero,
        elevation: 0.0,
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? disabledBackground
              : background,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? disabledForeground
              : foreground,
        ),
      ),
    );
  }

  /// TextButton.
  static TextButtonThemeData _buildTextButtonThemeData({
    required Color active,
    required Color inactive,
  }) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: active,
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          textStyle: small,
        ),
      );

  /// Text.
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

  /// ColorScheme
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
        onPrimary: isLight ? LightColors.white : DarkColors.white,
        onSecondary: const Color(0xFFFF00FF),
        onBackground: isLight ? LightColors.main : DarkColors.white,
        onSurface: isLight ? LightColors.secondary : DarkColors.white,
        onError: const Color(0xFFFF00FF),
      );

  /// Slider.
  static SliderThemeData _buildSliderThemeData({
    required Color active,
    required Color inactive,
    required Color thumb,
  }) =>
      SliderThemeData(
        activeTrackColor: active,
        inactiveTrackColor: inactive,
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        thumbColor: thumb,
        trackHeight: 2.0,
        // Можно унаследоваться от RoundedRectRangeSliderTrackShape,
        // переопределить метод paint и установить additionalActiveTrackHeight=0,
        // но при trackHeight: 2.0 закругления все равно не отрисовываются
        rangeTrackShape: const RectangularRangeSliderTrackShape(),
      );

  /// InputDecoration.
  static InputDecorationTheme _buildInputDecorationTheme({
    required bool isLight,
  }) {
    final inactiveBlack =
        isLight ? LightColors.inactiveBlack : DarkColors.inactiveBlack;
    final green = isLight ? LightColors.green : DarkColors.green;
    final error = isLight ? LightColors.error : DarkColors.error;
    final onSurface = isLight ? LightColors.secondary2 : DarkColors.white;

    return InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      hintStyle: text.copyWith(color: inactiveBlack),
      border: _buildOutlineInputBorder(
        color: inactiveBlack.withOpacity(0.4),
      ),
      focusedBorder: _buildOutlineInputBorder(
        color: green.withOpacity(0.4),
        width: 2.0,
      ),
      errorBorder: _buildOutlineInputBorder(
        color: error.withOpacity(0.4),
      ),
      focusedErrorBorder: _buildOutlineInputBorder(
        color: error.withOpacity(0.4),
        width: 2.0,
      ),
      suffixIconColor: onSurface,
    );
  }

  /// TextSelection.
  static TextSelectionThemeData _buildTextSelectionThemeData({
    required Color color,
  }) =>
      TextSelectionThemeData(
        cursorColor: color,
        selectionColor: color.withOpacity(0.5),
        selectionHandleColor: color,
      );

  /// OutlineInputBorder для InputDecoration.
  static OutlineInputBorder _buildOutlineInputBorder({
    required Color color,
    double width = 1.0,
  }) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );

  /// ListTile.
  static ListTileThemeData _buildListTileThemeData({required Color color}) =>
      ListTileThemeData(textColor: color);

  /// Divider.
  static DividerThemeData _buildDividerThemeData({required Color color}) =>
      DividerThemeData(
        color: color,
        thickness: 0.8,
      );

  /// BottomNavigationBar.
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
