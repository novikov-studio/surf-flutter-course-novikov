import 'package:flutter/material.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/res/themes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();

  static _AppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>();
}

class _AppState extends State<App> {
  bool _isLightTheme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: _isLightTheme ? Themes.light : Themes.dark,
      home: const HomeScreen(),
    );
  }

  void toggleTheme() {
    setState(() {
      _isLightTheme = !_isLightTheme;
    });
  }
}
