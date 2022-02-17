import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/svg_icon.dart';

class DarkenImage extends StatelessWidget {
  static const _gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0x66252849), Color(0x083B3E5B)],
      begin: Alignment(0.5, -0.3125),
      end: Alignment(0.5, 1.6354),
    ),
    backgroundBlendMode: BlendMode.multiply,
  );

  final String url;

  const DarkenImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, provider) =>
          Ink.image(
            image: provider,
            fit: BoxFit.cover,
            child: const DecoratedBox(
              decoration: _gradientDecoration,
            ),
          ),
      progressIndicatorBuilder: (context, _, progress) =>
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(color: theme.colorScheme.inactiveBlack),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: theme.cardColor,
                  color: theme.colorScheme.inactiveBlack,
                  value: progress.progress,
                ),
              ),
            ),
          ),
      // ignore: avoid_annotating_with_dynamic
      errorWidget: (context, _, dynamic __) =>
          DecoratedBox(
            decoration:
            BoxDecoration(color: theme.colorScheme.error.withOpacity(0.15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  AppIcons.error,
                  color: theme.colorScheme.error,
                  size: 32.0,
                ),
                spacerH8,
                Text(
                  AppStrings.imageLoadingError,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],
            ),
          ),
    );
  }
}
