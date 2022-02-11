import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final double? size;

  const SvgIcon(this.path, {Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: IconTheme.of(context).color,
      width: size,
      height: size,
    );
  }
}
