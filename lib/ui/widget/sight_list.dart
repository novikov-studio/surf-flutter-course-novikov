import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightList extends StatelessWidget {
  final Iterable<Sight> sights;
  final Widget empty;
  final CardMode mode;

  const SightList({
    Key? key,
    required this.sights,
    required this.empty,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sights.isEmpty
        ? empty
        : SingleChildScrollView(
          child: Column(
              children: sights
                  .map(
                    (sight) => Padding(
                      key: ValueKey(sight.id),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: SightCard(
                        sight: sight,
                        mode: mode,
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
        );
  }
}
