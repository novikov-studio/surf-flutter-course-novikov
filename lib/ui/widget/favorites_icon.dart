import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';

class FavoritesIcon extends StatelessWidget {
  final bool liked;
  final VoidCallback? onTap;

  const FavoritesIcon({Key? key, required this.liked, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(novikov): заменить на [IconButton]
    return Container(
      width: 20.0,
      height: 18.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2.0),
      ),
    );
  }
}
