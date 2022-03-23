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

    return SliverList(
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
