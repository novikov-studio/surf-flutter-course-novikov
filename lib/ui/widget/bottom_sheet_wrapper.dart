import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Обертка, позволяющая использовать прокрутку внутри ModalBottomSheet.
class BottomSheetWrapper extends StatelessWidget {
  final ScrollableWidgetBuilder builder;

  const BottomSheetWrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (context, controller) => Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            builder(context, controller),
            Positioned(
              top: 12.0,
              height: 4.0,
              width: 40.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: theme.colorScheme.white,
                ),
              ),
            ),
            const Positioned(
              top: 16.0,
              right: 16.0,
              child: SvgIcon(AppIcons.clear, size: 45.0),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              width: 45.0,
              height: 45.0,
              child: ClipOval(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    radius: 45.0,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
