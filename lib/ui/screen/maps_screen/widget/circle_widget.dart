import 'package:flutter/material.dart';

/// Простой круг.
class CircleWidget extends StatelessWidget {
  final Color color;
  final double size;

  const CircleWidget({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
