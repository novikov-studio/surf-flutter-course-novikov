import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/sight_details_text.dart';

/// Экран "Детализация".
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
                // При длинном описании кнопки уходят за пределы экрана - это плохо
                // В идеале:
                //   Если описание достаточно короткое, изображение - 1:1
                //   Если описание длинное:
                //      изображение ужимается по высоте максимум до 3:2
                //      если все равно не хватает высоты, у описания появляется прокрутка
                // Но пока такой фокус не удался
                child: ElevatedButton(
                  onPressed: () {
                    Utils.logButtonPressed('details.back');
                    context.popScreen();
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
