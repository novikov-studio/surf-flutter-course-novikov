import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/controls/darken_image.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/holders/favorites.dart';
import 'package:places/ui/widget/holders/sights.dart';

/// Верхняя часть карточки [SightCard].
class SightCardImage extends StatelessWidget {
  final Sight sight;
  final CardMode mode;

  const SightCardImage({
    Key? key,
    required this.sight,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DarkenImage(url: sight.urls.first),
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Text(
            sight.type,
            style: Theme.of(context).smallBoldWhite,
          ),
        ),
        Positioned(
          top: 8.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Кнопка "Запланировать"
              if (sight.isLiked && !sight.isVisited)
                _SvgButton(
                  path: AppIcons.calendar,
                  onPressed: () => planVisiting(context, sight),
                ),

              /// Кнопка "Поделиться"
              if (sight.isVisited)
                _SvgButton(
                  path: AppIcons.share,
                  onPressed: () {
                    Utils.logButtonPressed('card.share');
                  },
                ),

              spacerW8,

              /// Кнопка "Избранное" - добавить/удалить
              _SvgButton(
                path: sight.isLiked
                    ? (mode == CardMode.favorites
                        ? AppIcons.close
                        : AppIcons.heartFilled)
                    : AppIcons.heart,
                onPressed: () => toggleInFavorites(context, sight),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Удалние/добавление в Избранное.
  static Future<void> toggleInFavorites(
    BuildContext context,
    Sight sight,
  ) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final favoritesProvider = Favorites.of(context)!;
    final sightHolder = SightCard.of(context)!;

    try {
      sight.isLiked
          ? await favoritesProvider.remove(sight)
          : await favoritesProvider.add(sight);
      sightHolder.value = sight.copyWith(isLiked: !sight.isLiked);
    } on Exception catch (e, stacktrace) {
      debugPrint('$e, $stacktrace');
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text(AppStrings.tryLater),
      ));
    }
  }

  /// Запланировать.
  static Future<void> planVisiting(BuildContext context, Sight sight) async {
    final sightRepository = Sights.of(context)!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final sightHolder = SightCard.of(context)!;

    final plannedDate =
        await _pickDateTime(context, initial: sight.plannedDate);

    try {
      await sightRepository.update(sight.copyWith(plannedDate: plannedDate));
      sightHolder.value = sight.copyWith(plannedDate: plannedDate);
    } on Exception catch (e, stacktrace) {
      debugPrint('$e, $stacktrace');
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text(AppStrings.tryLater),
      ));
    }
  }

  static Future<DateTime?> _pickDateTime(
    BuildContext context, {
    DateTime? initial,
  }) async {
    final theme = Theme.of(context);
    final pickerTheme = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: theme.colorScheme.green,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: theme.colorScheme.green),
      ),
    );

    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: initial ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
      helpText:
          initial == null ? AppStrings.scheduleDate : AppStrings.rescheduleDate,
      builder: (context, child) => Theme(
        data: pickerTheme,
        child: child!,
      ),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initial ?? now),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: pickerTheme,
            child: Localizations.override(
              context: context,
              locale: const Locale('ru', 'RU'),
              child: child,
            ),
          ),
        ),
      );

      if (time != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }

    return null;
  }
}

class _SvgButton extends StatelessWidget {
  final String path;
  final VoidCallback? onPressed;

  const _SvgButton({Key? key, required this.path, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgIcon(path),
      splashRadius: 20.0,
      constraints: const BoxConstraints(minWidth: 24.0, minHeight: 24.0),
    );
  }
}
