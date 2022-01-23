import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_styles.dart';

class SightCardText extends StatelessWidget {
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
                  style: text,
                ),
                if (banner != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
                    child: Text(
                      banner!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: smallGreen,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: smallSecondary2,
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
