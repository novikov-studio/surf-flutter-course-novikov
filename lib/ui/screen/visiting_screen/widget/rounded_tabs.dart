import 'package:flutter/material.dart';

/// Переключатель страниц.
class RoundedTabs extends StatelessWidget implements PreferredSizeWidget {
  final List<String> items;

  @override
  Size get preferredSize => const Size(double.infinity, 52.0);

  const RoundedTabs({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        clipBehavior: Clip.antiAlias,
        // TODO(novikov): Добавить splash c закруглением при нажатии
        // Судя по исходникам TabBar, каждый таб оборачивается в InkWell,
        // поэтому штатными средствами можно только убрать splash.
        // Ждем-с: https://github.com/flutter/flutter/issues/50341
        child: Container(
          height: 40.0,
          color: Theme.of(context).cardColor,
          child: TabBar(
            tabs: items.map(Text.new).toList(growable: false),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
