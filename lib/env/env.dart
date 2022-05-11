/// Класс для хранения параметров, зависящих от типа сборки.
abstract class Env {
  static late BuildType _buildType;
  static late EnvStrings _strings;

  /// Тип сборки.
  static BuildType get buildType => _buildType;

  /// Строковые ресурсы сборки.
  static EnvStrings get strings => _strings;

  static void init({
    required BuildType buildType,
    required EnvStrings strings,
  }) {
    _buildType = buildType;
    _strings = strings;
  }
}

/// Строки.
class EnvStrings {
  final String appTitle;
  final String mainScreenTitle;

  EnvStrings({
    required this.appTitle,
    required this.mainScreenTitle,
  });
}

/// Типы сборок.
enum BuildType { dev, prod, profile }

extension BuildTypeExtension on BuildType {
  bool get isProd => this == BuildType.prod;

  bool get isDev => this == BuildType.dev;

  bool get isProfile => this == BuildType.profile;
}
