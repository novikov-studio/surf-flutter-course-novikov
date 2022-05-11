import 'package:places/env/env.dart';
import 'package:places/runner.dart';

/// Точка входа для RELEASE-сборки.
void main() {
  Env.init(
    buildType: BuildType.prod,
    strings: EnvStrings(
      appTitle: 'Интересные места',
      mainScreenTitle: 'Список интересных\u00A0мест',
    ),
  );

  runner();
}
