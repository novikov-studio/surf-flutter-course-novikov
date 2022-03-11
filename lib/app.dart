import 'package:flutter/material.dart';
import 'package:places/domain/favorites_provider.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/favorites.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Favorites(
      favoritesProvider: FavoritesProvider.createProvider(),
      child: ValueListenableBuilder<bool>(
        valueListenable: Utils.isLight,
        builder: (_, value, __) => MaterialApp(
          title: 'Places',
          theme: value ? Themes.light : Themes.dark,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
