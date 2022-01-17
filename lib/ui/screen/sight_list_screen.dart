import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  static const _backgroundColor = Colors.white;
//  static const _mainColor = Color(0xFF252849);
  static const _secondaryColor = Color(0xFF3B3E5B);
  static const _yellowColor = Color(0xFFFCDD3D);
  static const _greenColor = Color(0xFF4CAF50);

  static const _largeTitle = TextStyle(
    color: _secondaryColor,
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            style: _largeTitle,
            children: [
              TextSpan(
                text: 'С',
                style: TextStyle(color: _greenColor),
              ),
              TextSpan(text: 'писок\n'),
              TextSpan(
                text: 'и',
                style: TextStyle(color: _yellowColor),
              ),
              TextSpan(text: 'нтересных мест'),
            ],
          ),
        ),
        backgroundColor: _backgroundColor,
        elevation: 0.0,
        toolbarHeight: 136.0,
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
