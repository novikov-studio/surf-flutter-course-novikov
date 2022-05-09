import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Кнопка над картой.
class MapFab<T> extends StatelessWidget {
  final ListenableEntityState<T> listenable;
  final String icon;
  final VoidCallback onPressed;
  final Object? heroTag;

  const MapFab({
    Key? key,
    required this.listenable,
    required this.icon,
    required this.onPressed,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<T>(
      listenableEntityState: listenable,

      /// In Progress.
      loadingBuilder: (_, __) => FloatingActionButton(
        heroTag: heroTag,
        child: const SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
        onPressed: null,
      ),

      /// Idle.
      builder: (_, __) => FloatingActionButton(
        heroTag: heroTag,
        child: SvgIcon(
          icon,
          size: 32.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
