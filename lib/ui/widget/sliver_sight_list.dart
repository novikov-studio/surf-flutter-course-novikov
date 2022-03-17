import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/widget/controls/spacers.dart';

/// Виджет для отображения списка карточек мест.
///
/// Используется на экранах [SightListScreen] и [VisitingScreen].
class SliverSightList extends SliverList {
  factory SliverSightList({
    Key? key,

    /// Список элементов для отображения.
    required List<Sight> sights,

    /// Виджет, отображаемый в случае пустого списка элементов.
    required Widget empty,

    /// Режим отображения [CardMode] карточки места.
    ///
    /// Карточка одного и того же места может отображаться по-разному,
    /// в зависимости от того, на каком экране она находится
    required CardMode mode,

    /// Callback на перемещение карточки.
    OnOrderChanged? onOrderChanged,
  }) =>
      SliverSightList._(
        key: key,
        sights: sights,
        empty: empty,
        mode: mode,
        onOrderChanged: onOrderChanged,
        draggable: onOrderChanged != null && sights.length > 1,
      );

  SliverSightList._({
    Key? key,
    required List<Sight> sights,
    required Widget empty,
    required CardMode mode,
    OnOrderChanged? onOrderChanged,
    required final bool draggable,
  }) : super(
          key: key,
          delegate: SliverChildListDelegate(
            sights.isEmpty
                ? <Widget>[empty]
                : sights
                    .expand((sight) => [
                          // Разделитель
                          if (draggable)
                            _DragTargetSpacer(
                              id: sight.id,
                              onOrderChanged: onOrderChanged,
                            )
                          else
                            spacerH24,

                          // Карточка
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SightCard(sight: sight, mode: mode),
                          ),

                          // Хвостовой разделитель
                          if (sight == sights.last)
                            if (draggable)
                              _DragTargetSpacer(
                                id: null,
                                onOrderChanged: onOrderChanged,
                              )
                            else
                              spacerH24,
                        ])
                    .toList(growable: false),
          ),
        );
}

/// Разделитель, выступающий в роли приемника карточек при ручной сортировке.
class _DragTargetSpacer extends StatelessWidget {
  final String? id;
  final OnOrderChanged? onOrderChanged;

  const _DragTargetSpacer({Key? key, required this.id, this.onOrderChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
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
    );
  }

  void _onDragComplete(String sourceId) {
    if (onOrderChanged != null) {
      onOrderChanged!(sourceId, id);
    }
  }
}

typedef OnOrderChanged = void Function(
  String sourceId,
  String? insertAfterId,
);
