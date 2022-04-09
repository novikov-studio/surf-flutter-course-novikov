import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/sight_card_image.dart';
import 'package:places/ui/widget/sight_card_text.dart';
import 'package:provider/provider.dart';

/// Виджет карточки места.
class SightCard extends ChangeNotifierProvider<SightNotifier> {
  SightCard({
    Key? key,
    required Sight sight,
    required CardMode mode,
  }) : super(
          key: key,
          create: (_) => SightNotifier(sight),
          child: Consumer<SightNotifier>(
            builder: (_, notifier, __) =>
                _SightCard(sight: notifier.value, mode: mode),
          ),
        );

  static SightNotifier? of(BuildContext context) =>
      context.read<SightNotifier>();
}

typedef SightNotifier = ValueNotifier<Sight>;

class _SightCard extends StatelessWidget {
  final Sight sight;
  final CardMode mode;

  const _SightCard({
    Key? key,
    required this.sight,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final draggable = mode == CardMode.favorites;
    final dismissible = draggable;

    Widget card = Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _showDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96.0,
              child: SightCardImage(
                sight: sight,
                mode: mode,
              ),
            ),
            SightCardText(
              sight: sight,
              mode: mode,
            ),
          ],
        ),
      ),
    );

    if (dismissible) {
      card = Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                  bottom: Radius.circular(12.0),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            child: Column(
              children: [
                const SvgIcon(AppIcons.bucket),
                spacerH8,
                Text(AppStrings.delete, style: theme.superSmall500White),
              ],
            ),
          ),
          Dismissible(
            child: card,
            key: ValueKey('dm_${sight.id}'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) =>
                SightCardImage.toggleInFavorites(context, sight),
          ),
        ],
      );
    }

    if (draggable) {
      final mediaQuery = MediaQuery.of(context);
      final isPortrait = mediaQuery.orientation == Orientation.portrait;
      final maxWidth = isPortrait
          ? mediaQuery.size.width - 16.0 * 2
          : (mediaQuery.size.width - 16.0 * 3) / 2;

      card = LongPressDraggable<String>(
        child: card,
        data: sight.id,
        axis: isPortrait ? Axis.vertical : null,
        childWhenDragging: const SizedBox(),
        feedback: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Opacity(opacity: 0.8, child: card),
          ),
        ),
      );
    }

    return card;
  }

  Future<void> _showDetails(BuildContext context) async {
    final placeInteractor = context.placeInteractor;
    final sightNotifier = context.read<SightNotifier>();
    final favoritesNotifier = context.read<FavoritesNotifier?>();

    // Показываем экран детализации
    await context.pushBottomSheet(AppRoutes.details, args: sight.id);

    // Обновляем текуший экран, если требуется.
    // Логичней было бы возвращать обновленный Sight из детализации,
    // но и запрашивать Sight по id при входе, имея Sight на руках - тоже мало логики.
    // Видимо, расчет на кэширование.
    final newSight = await placeInteractor.getOne(id: int.parse(sight.id));
    // TODO(novikov): Переопределить == в Sight
    if (newSight != sight) {
      favoritesNotifier != null && !newSight.isLiked
          ? favoritesNotifier.trigger()
          : sightNotifier.value = newSight;
    }
  }
}

enum CardMode { list, map, favorites }
