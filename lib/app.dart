import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      // home: MyFirstWidget(),
      home: const SightListScreen(),
    );
  }
}
