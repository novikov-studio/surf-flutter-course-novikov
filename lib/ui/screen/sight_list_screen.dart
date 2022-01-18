import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_strings.dart';

/// Экран "Список мест"
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  static const _largeTitle = TextStyle(
    color: AppColors.secondary,
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final lst = _smartSplit(sAppTitle);

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: _largeTitle,
            children: [
              TextSpan(
                text: lst.first[0],
                style: const TextStyle(color: AppColors.green),
              ),
              TextSpan(text: '${lst.first.substring(1, lst.first.length)}\n'),
              TextSpan(
                text: lst.last[0],
                style: const TextStyle(color: AppColors.yellow),
              ),
              TextSpan(text: lst.last.substring(1, lst.last.length)),
            ],
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0.0,
        toolbarHeight: 136.0,
      ),
      backgroundColor: AppColors.background,
    );
  }

  /// Метод делит строку на 2 части:
  /// либо по символу '\n',
  /// либо по ближайшему к середине строки пробелу
  List<String> _smartSplit(String source) {
    var lst = source.split('\n');
    if (lst.length == 1) {
      var div = sAppTitle.length ~/ 2;
      final idx1 = sAppTitle.substring(0, div).lastIndexOf(' ');
      final idx2 = sAppTitle.indexOf(' ', div);
      if (idx1 < 0 && idx2 >= 0) {
        div = idx2;
      } else if (idx1 >= 0 && idx2 < 0) {
        div = idx1;
      } else if (idx1 >= 0 && idx2 >= 0) {
        div = div - idx1 < idx2 - div ? idx1 : idx2;
      }

      lst = [
        source.substring(0, div).trim(),
        source.substring(div).trim(),
      ];
    }

    return lst;
  }
}
