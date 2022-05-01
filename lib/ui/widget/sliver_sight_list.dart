import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/widget/spacers.dart';

/// Виджет для отображения списка карточек мест.
///
/// Используется на экранах "Список мест" и "Избранное".
class SliverSightList extends StatelessWidget {
  /// Список элементов для отображения.
  final List<Sight> sights;

  /// Виджет, отображаемый в случае пустого списка элементов.
  final Widget empty;

  /// Режим отображения [CardMode] карточки места.
  ///
  /// Карточка одного и того же места может отображаться по-разному,
  /// в зависимости от того, на каком экране она находится
  final CardMode mode;

  /// Callback на перемещение карточки.
  final OnOrderChanged? onOrderChanged;

  const SliverSightList({
    Key? key,
    required this.sights,
    required this.empty,
    required this.mode,
    this.onOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sights.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: empty),
      );
    }

    final draggable = onOrderChanged != null && sights.length > 1;
    final isPortrait = context.isPortrait;

    final listDelegate = SliverSightListDelegate(
      sights,
      mode: mode,
      draggable: draggable,
      isGrid: !isPortrait,
      onOrderChanged: onOrderChanged,
    );

    return isPortrait
        ? SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(delegate: listDelegate),
          )
        : SliverPadding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverSightGridDelegate(),
              delegate: listDelegate,
            ),
          );
  }
}

/// Делегат для формирования расположения элементов в таблице.
class SliverSightGridDelegate
    extends SliverGridDelegateWithFixedCrossAxisCount {
  SliverSightGridDelegate()
      : super(
          crossAxisCount: 2,
          mainAxisExtent: 250.0,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 24.0,
        );
}

/// Делегат для формирования набора элементов списка или таблицы.
class SliverSightListDelegate extends SliverChildListDelegate {
  SliverSightListDelegate(
    List<Sight> sights, {
    required bool draggable,
    required CardMode mode,
    required bool isGrid,
    OnOrderChanged? onOrderChanged,
  }) : super(
          [
            ...sights.map(
              (sight) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Разделитель
                  _DragTargetSpacer(
                    id: sight.id,
                    enabled: draggable,
                    onOrderChanged: onOrderChanged,
                  ),

                  // Карточка
                  if (isGrid)
                    Expanded(
                      child: SightCard(key: ValueKey(sight.id), sight: sight, mode: mode),
                    )
                  else
                    SightCard(key: ValueKey(sight.id), sight: sight, mode: mode),
                ],
              ),
            ),

            // Хвостовой разделитель
            if (!isGrid)
              _DragTargetSpacer(
                id: null,
                enabled: draggable,
                onOrderChanged: onOrderChanged,
              ),
          ],
        );
}

/// Разделитель, выступающий в роли приемника карточек при ручной сортировке.
class _DragTargetSpacer extends StatelessWidget {
  final int? id;
  final bool enabled;
  final OnOrderChanged? onOrderChanged;

  const _DragTargetSpacer({
    Key? key,
    required this.id,
    this.enabled = true,
    this.onOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return enabled
        ? DragTarget<int>(
            onWillAccept: (value) {
              return value != id;
            },
            onAccept: _onDragComplete,
            builder: (context, candidateData, rejectedData) {
              return SizedBox(
                height: 24.0,
                child: candidateData.isNotEmpty
                    ? Divider(
                        color: Theme.of(context).colorScheme.green,
                        thickness: 4.0,
                      )
                    : null,
              );
            },
          )
        : spacerH24;
  }

  void _onDragComplete(int sourceId) {
    if (onOrderChanged != null) {
      onOrderChanged!(sourceId, id);
    }
  }
}

typedef OnOrderChanged = void Function(
  int sourceId,
  int? insertAfterId,
);
