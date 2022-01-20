import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';

class SightCardImage extends StatelessWidget {
  static const _smallBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  final String url;
  final String? category;
  final Widget? icon;

  const SightCardImage({
    Key? key,
    required this.url,
    this.category,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // TODO(novikov): заменить на [CachedNetworkImage]
        // TODO(novikov): наложить линейный градиент затемнения
        Container(color: Colors.blue.shade200),
        if (category != null)
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              category!,
              style: _smallBold,
            ),
          ),
        if (icon != null)
          Positioned(
            top: 16.0,
            right: 16.0,
            child: icon!,
          ),
      ],
    );
  }
}
