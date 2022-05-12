import 'package:places/env/env.dart';
import 'package:places/runner.dart';

/// Точка входа для PROFILE-сборки.
void main() {
  Env.init(
    buildType: BuildType.profile,
    strings: EnvStrings(
      appTitle: 'Интересные места - PROFILE',
      mainScreenTitle: 'Список интересных мест - PROFILE',
    ),
  );

  runner();
}
