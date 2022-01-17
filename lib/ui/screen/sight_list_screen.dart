import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  static const _backgroundColor = Colors.white;
  static const _mainColor = Color(0xFF252849);

  static const _largeTitle = TextStyle(
    color: _mainColor,
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список\nинтересных мест', style: _largeTitle),
        backgroundColor: _backgroundColor,
        elevation: 0.0,
        toolbarHeight: 136.0,
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
