import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Достопримечательности'),
      ),
      body: const Center(
        child: Text('Список достопримечательностей'),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
