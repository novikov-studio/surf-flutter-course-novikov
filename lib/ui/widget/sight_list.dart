import 'package:flutter/gestures.dart';
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
class SightList extends StatelessWidget {
  /// Список элементов для отображения.
  final Iterable<Sight> sights;

  /// Виджет, отображаемый в случае пустого списка элементов.
  final Widget empty;

  /// Режим отображения [CardMode] карточки места.
  ///
  /// Карточка одного и того же места может отображаться по-разному,
  /// в зависимости от того, на каком экране она находится.
  final CardMode mode;

  /// Callback на перемещение карточки.
  final OnOrderChanged? onOrderChanged;

  const SightList({
    Key? key,
    required this.sights,
    required this.empty,
    required this.mode,
    this.onOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final draggable = onOrderChanged != null && sights.length > 1;

    return sights.isEmpty
        ? empty
        : SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...sights.expand(
                    (sight) => [
                      if (draggable)
                        _DragTargetSpacer(
                          id: sight.id,
                          onOrderChanged: onOrderChanged,
                        )
                      else
                        spacerH24,
                      SightCard(
                        key: ValueKey(sight.id),
                        sight: sight,
                        mode: mode,
                      ),
                    ],
                  ),
                  if (draggable)
                    _DragTargetSpacer(
                      id: null,
                      onOrderChanged: onOrderChanged,
                    )
                  else
                    spacerH24,
                ],
              ),
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
