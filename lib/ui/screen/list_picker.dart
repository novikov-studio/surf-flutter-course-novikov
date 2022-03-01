import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/simple_app_bar.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Полноэкранный диалог для выбора одного значения из списка.
class ListPicker<T> extends StatefulWidget {
  /// Заголовок экрана.
  final String title;

  /// Список значений.
  final List<T> items;

  /// Список отображаемых строк.
  /// Если опущен, используется строковое представление элементов [items].
  final List<String>? names;

  /// Значение, выбранное по-умолчанию.
  final T? initialValue;

  /// Callback, вызываемый при подтверждении вызова.
  final void Function(T value) onChoiceDone;

  const ListPicker({
    Key? key,
    required this.title,
    required this.items,
    this.initialValue,
    this.names,
    required this.onChoiceDone,
  })  : assert(names == null || items.length == names.length),
        super(key: key);

  @override
  _ListPickerState createState() => _ListPickerState<T>();
}

class _ListPickerState<T> extends State<ListPicker<T>> {
  int? index;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      final initialIndex = widget.items.indexOf(widget.initialValue!);
      if (initialIndex >= 0) {
        index = initialIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.dividerColor.withOpacity(0.24);

    return Scaffold(
      appBar: SimpleAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: widget.items
              .asMap()
              .entries
              .map(
                (entry) => ListTile(
                  title:
                      Text(widget.names?[entry.key] ?? entry.value.toString()),
                  trailing:
                      entry.key == index ? const SvgIcon(AppIcons.tick) : null,
                  onTap: () => _onItemCheck(entry.key),
                  iconColor: theme.colorScheme.green,
                  contentPadding: EdgeInsets.zero,
                  shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: dividerColor,
                      width: 0.8,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ElevatedButton(
          child: const Text(AppStrings.save),
          onPressed: index != null ? _onSaveButtonPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48.0),
          ),
        ),
      ),
    );
  }

  void _onItemCheck(int index) {
    setState(() {
      this.index = index;
    });
  }

  void _onSaveButtonPressed() {
    if (index != null) {
      widget.onChoiceDone(widget.items[index!]);
    }
  }
}
