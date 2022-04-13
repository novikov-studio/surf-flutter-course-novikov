import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore_for_file: prefer-single-widget-per-file

/// Набор классов и виджетов для построения responsive UI.
///
/// [Responsive] - сохраняет responsive-информацию в дереве виджетов.
/// [DeviceAdapter] - разделяет верстку по типам устройств.
/// [HandsetAdapter] - разделяет верстку для телефонов с разным размером экрана.
/// [TabletAdapter] - разделяет верстку для планшетов с разным размером экрана.
/// [FontsSizeAdapter] - переопределяет размеры шрифтов текущей темы.

/// Виджет для хранения responsive-информации в дереве виджетов.
///
/// Желательно хранить как можно ближе к корню, например:
///
///     return MaterialApp(
///       builder: (_, child) => Responsive(child: child!),
///     );
class Responsive extends StatelessWidget {
  final Widget child;

  const Responsive({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ProxyProvider0<ScreenInfo>(
        update: (context, _) => ScreenInfo.from(context, orientation),
        child: child,
      ),
    );
  }

  static ScreenInfo? of(BuildContext context) =>
      context.read<ScreenInfo>();
}

/// [DeviceAdapter] предоставляет набор билдеров для построения поддерева
/// в зависимости от типа устройства:
///   [DeviceType.handset] - телефон
///   [DeviceType.tablet] - планшет
///
/// В комбмнации с [HandsetAdapter] и [TabletAdapter] позволяет
/// максимально точно разделить верстку:
///
/// Например:
///     return DeviceAdapter(
///       handset: (_) => HandsetAdapter(
///         small: (_) => ScreenSmallPhone(),
///         orElse: (_) => ScreenAnyPhone(),
///       ),
///       tablet: (_) => ScreenAnyTablet(),
///       orElse: (_) => ScreenLarge(),
///     );
///
/// Данный код использует разную верстку для следующих групп устройств:
///  - для телефонов с маленьким экраном
///  - для телефонов со средним и большим экраном
///  - для всех планшетов
///  - для десктопов.
class DeviceAdapter extends StatelessWidget {
  final WidgetBuilder? handset;
  final WidgetBuilder? tablet;
  final WidgetBuilder? orElse;

  const DeviceAdapter({
    Key? key,
    this.handset,
    this.tablet,
    this.orElse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    if (screen == null) {
      return orElse!(context);
    }

    switch (screen.deviceType) {
      case DeviceType.handset:
        return handset != null ? handset!(context) : orElse!(context);

      case DeviceType.tablet:
        return tablet != null ? tablet!(context) : orElse!(context);

      default:
        return orElse!(context);
    }
  }
}

/// [HandsetAdapter] предоставляет набор билдеров для построения поддерева
/// в зависимости от размера экрана телефона.
///
/// Например:
///     return HandsetAdapter(
///         small: (_) => ScreenSmallPhone(),
///         orElse: (_) => ScreenUniversal(),
///       );
///
///  Данный код использует отдельную верстку для телефонов с маленьким экраном.
class HandsetAdapter extends StatelessWidget {
  final WidgetBuilder? small;
  final WidgetBuilder? medium;
  final WidgetBuilder? large;
  final WidgetBuilder? orElse;

  const HandsetAdapter({
    Key? key,
    this.small,
    this.medium,
    this.large,
    this.orElse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    if (screen == null || screen.deviceType != DeviceType.handset) {
      return orElse!(context);
    }

    switch (screen.screenType) {
      case ScreenType.small:
        return small != null ? small!(context) : orElse!(context);

      case ScreenType.medium:
        return medium != null ? medium!(context) : orElse!(context);

      case ScreenType.large:
        return large != null ? large!(context) : orElse!(context);

      default:
        return orElse!(context);
    }
  }
}

/// [TabletAdapter] предоставляет набор билдеров для построения поддерева
/// в зависимости от размера экрана планшета.
///
/// Например:
///     return TabletAdapter(
///         small: (_) => ScreenSmallTablet(),
///         orElse: (_) => ScreenUniversal(),
///       );
///
///  Данный код использует отдельную верстку для планшетов с маленьким экраном.
class TabletAdapter extends StatelessWidget {
  final WidgetBuilder? small;
  final WidgetBuilder? large;
  final WidgetBuilder? orElse;

  const TabletAdapter({
    Key? key,
    this.small,
    this.large,
    this.orElse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = Responsive.of(context);
    if (screen == null || screen.deviceType != DeviceType.tablet) {
      return orElse!(context);
    }

    switch (screen.screenType) {
      case ScreenType.small:
        return small != null ? small!(context) : orElse!(context);

      case ScreenType.large:
        return large != null ? large!(context) : orElse!(context);

      default:
        return orElse!(context);
    }
  }
}

/// Адаптер размера шрифтов, используемых в теме.
class FontsSizeAdapter extends StatefulWidget {
  final Widget? child;
  final WidgetBuilder? builder;
  final double? delta;
  final double? factor;

  const FontsSizeAdapter({
    Key? key,
    this.child,
    this.builder,
    this.delta,
    this.factor,
  })  : assert(child != null || builder != null, 'child or builder expected'),
        assert((child == null) != (builder == null),
            'only child or builder allowed'),
        super(key: key);

  @override
  State<FontsSizeAdapter> createState() => _FontsSizeAdapterState();
}

class _FontsSizeAdapterState extends State<FontsSizeAdapter> {
  ThemeData? _themeData;

  @override
  void didChangeDependencies() {
    final needAdapt = widget.factor != null || widget.delta != null;

    if (needAdapt) {
      final theme = Theme.of(context);

      final fontSizeFactor = widget.factor ?? 1.0;
      final fontSizeDelta = widget.delta ?? 0.0;

      _themeData = theme.copyWith(
        textTheme: theme.textTheme.apply(
          fontSizeFactor: fontSizeFactor,
          fontSizeDelta: fontSizeDelta,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: theme.elevatedButtonTheme.style?.copyWith(
            textStyle: theme.elevatedButtonTheme.style?.textStyle?.apply(
              fontSizeFactor: fontSizeFactor,
              fontSizeDelta: fontSizeDelta,
            ),
          ),
        ),
        // TODO(novikov): адаптировать все текстовые элементы темы
      );
    } else {
      _themeData = null;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final child =
        widget.child != null ? widget.child! : widget.builder!(context);

    return _themeData != null
        ? Theme(
            data: _themeData!,
            child: child,
          )
        : child;
  }
}

extension on MaterialStateProperty<TextStyle?> {
  MaterialStateProperty<TextStyle?> apply({
    required double fontSizeFactor,
    required double fontSizeDelta,
  }) =>
      MaterialStateProperty.all(resolve({})?.apply(
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ));
}

/// Информация о размерах экрна усттройства.
class ScreenInfo {
  final DeviceType deviceType;
  final ScreenType screenType;
  final bool isPortrait;

  ScreenInfo({
    required this.deviceType,
    required this.screenType,
    required this.isPortrait,
  });

  factory ScreenInfo.from(BuildContext context, Orientation orientation) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.shortestSide;

    // https://material.io/archive/guidelines/layout/responsive-ui.html#responsive-ui-breakpoints
    var device = DeviceType.desktop;
    var screen = ScreenType.large;

    if (width <= 600) {
      device = DeviceType.handset;
      if (width <= 360) {
        screen = ScreenType.small;
      } else if (width <= 400) {
        screen = ScreenType.medium;
      }
    } else if (width <= 960) {
      device = DeviceType.tablet;
      if (width <= 720) {
        screen = ScreenType.small;
      }
    }

    return ScreenInfo(
      deviceType: device,
      screenType: screen,
      isPortrait: orientation == Orientation.portrait,
    );
  }
}

/// Тип устройства.
enum DeviceType { handset, tablet, desktop }

/// Тип размера экрана.
enum ScreenType { small, medium, large }
