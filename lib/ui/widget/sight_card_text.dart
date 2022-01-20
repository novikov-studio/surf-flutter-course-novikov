import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';

class SightCardText extends StatelessWidget {
  static const _titleStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static const _subtitleStyle = TextStyle(
    color: AppColors.secondary2,
    fontSize: 14.0,
  );

  static const _bannerStyle = TextStyle(
    color: AppColors.green,
    fontSize: 14.0,
  );

  final String title;
  final String? banner;
  final String? subtitle;
  final int titleMaxLines;
  final VoidCallback? onButtonPressed;

  const SightCardText({
    Key? key,
    required this.title,
    this.banner,
    this.subtitle,
    this.titleMaxLines = 2,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: _titleStyle,
                ),
                if (banner != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
                    child: Text(
                      banner!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _bannerStyle,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _subtitleStyle,
                  ),
                ],
              ],
            ),
          ),
          if (onButtonPressed != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: TextButton(
                  onPressed: onButtonPressed,
                  child: const Icon(Icons.navigation),
                  style: TextButton.styleFrom(
                    primary: AppColors.white,
                    backgroundColor: AppColors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
