import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:places/ui/widget/spacers.dart';
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
  final Size? size;
  final double? borderRadius;

  final bool _showErrorText;

  const DarkenImage({
    Key? key,
    required this.url,
    this.size,
    this.borderRadius,
  })  : _showErrorText = borderRadius == null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CachedNetworkImage(
      imageUrl: url,
      height: size?.height,
      width: size?.width,
      imageBuilder: (context, provider) => borderRadius != null
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),
                image: DecorationImage(
                  image: provider,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Material(
              type: MaterialType.transparency,
              child: Ink.image(
                image: provider,
                fit: BoxFit.cover,
                child: const DecoratedBox(
                  decoration: _gradientDecoration,
                ),
              ),
            ),
      progressIndicatorBuilder: (context, _, progress) => const Loader(),
      // ignore: avoid_annotating_with_dynamic
      errorWidget: (context, _, dynamic __) => DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withOpacity(0.15),
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              AppIcons.error,
              color: theme.colorScheme.error,
              size: 32.0,
            ),
            if (_showErrorText) ...[
              spacerH8,
              Text(
                AppStrings.imageLoadingError,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
