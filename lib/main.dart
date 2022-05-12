import 'package:places/env/env.dart';
import 'package:places/runner.dart';

/// Точка входа для DEBUG-сборки.
void main() {
  Env.init(
    buildType: BuildType.dev,
    strings: EnvStrings(
      appTitle: 'Интересные места - DEV',
      mainScreenTitle: 'Список интересных мест. Debug-сборка',
    ),
  );

  runner();
}
