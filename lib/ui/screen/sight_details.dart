import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/sight_details_text.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: DarkenImage(url: sight.url),
              ),
              Positioned(
                left: 16.0,
                top: statusHeight + 16.0,
                height: 32.0,
                width: 32.0,
                // TODO(novikov): Сжимать изображение по высоте, чтобы умещались нижние кнопки
                child: ElevatedButton(
                  onPressed: () {
                    // TODO(novikov): Возрат на предыдущий экран
                    Utils.logButtonPressed('details.back');
                  },
                  child: const Icon(Icons.chevron_left),
                  style: theme.btnBack,
                ),
              ),
            ],
          ),
          spacerH24,
          Expanded(
            child: SingleChildScrollView(
              child: SightDetailsText(sight: sight),
            ),
          ),
        ],
      ),
    );
  }
}
