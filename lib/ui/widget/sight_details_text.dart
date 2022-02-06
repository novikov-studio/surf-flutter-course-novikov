import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';

class SightDetailsText extends StatelessWidget {
  final Sight sight;

  const SightDetailsText({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatStyle = TextButton.styleFrom(
      primary: Theme.of(context).colorScheme.onSurface,
      textStyle: Theme.of(context).smallOnSurface,
      padding: const EdgeInsets.symmetric(vertical: 11.0),
    );

    final coloredStyle = TextButton.styleFrom(
      primary: Theme.of(context).colorScheme.white,
      backgroundColor: Theme.of(context).colorScheme.green,
      padding: const EdgeInsets.all(15.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sight.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).titleOnSurface,
          ),
          Wrap(
            children: [
              Text(
                sight.type,
                style: Theme.of(context).smallBoldForDetailsType,
              ),
              if (sight.info != null)
                Text(sight.info!, style: Theme.of(context).smallForDetailsInfo),
            ],
            spacing: 16.0,
          ),
          if (sight.details != null) ...[
            spacerH24,
            Text(
              sight.details!.trimRight(),
              style: Theme.of(context).smallOnSurface,
            ),
          ],
          spacerH24,
          TextButton.icon(
            onPressed: () {
              // TODO(novikov): Обработчик нажатия кнопки "Построить маршрут"
            },
            icon: const Icon(Icons.navigation),
            label: Text(
              AppStrings.buildRoute,
              style: Theme.of(context).buttonWhite,
            ),
            style: coloredStyle,
          ),
          spacerH24,
          const Divider(),
          const SizedBox(width: 8.0),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO(novikov):  Обработчик нажатия кнопки "Запланировать"
                  },
                  icon: const Icon(Icons.calendar_view_month),
                  label: const Text(AppStrings.schedule),
                  style: flatStyle,
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO(novikov):  Обработчик нажатия кнопки "В Избранное"
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text(AppStrings.addFavorites),
                  style: flatStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
