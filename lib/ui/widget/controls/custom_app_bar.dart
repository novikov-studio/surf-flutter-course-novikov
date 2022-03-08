import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Widget? bottom;

  @override
  Size get preferredSize => Size(double.infinity, height);

  const CustomAppBar({
    Key? key,
    required this.title,
    this.height = 120.0,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).largeTitleForAppBar,
          ),
        ),
        if (bottom != null) bottom!,
      ],
    );
  }
}
