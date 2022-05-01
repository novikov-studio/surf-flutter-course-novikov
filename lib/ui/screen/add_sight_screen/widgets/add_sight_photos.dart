import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/widget/spacers.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Виджет для управления фото на экране [AddSightScreen].
class AddSightPhotos extends StatefulWidget {
  final List<String>? initialValue;
  final ValueChanged<List<String>> onChange;

  const AddSightPhotos({
    Key? key,
    this.initialValue,
    required this.onChange,
  }) : super(key: key);

  @override
  State<AddSightPhotos> createState() => _AddSightPhotosState();
}

class _AddSightPhotosState extends State<AddSightPhotos> {
  late final List<String> items;

  @override
  void initState() {
    super.initState();
    items = widget.initialValue ?? <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _AddCard(onTap: _addPhoto),
          ...items.expand((element) => [
                spacerW16,
                _PhotoCard(
                  fileName: element,
                  onNeedRemove: _removePhoto,
                ),
              ]),
        ],
      ),
    );
  }

  Future<void> _addPhoto() async {
    final fileNames = await showCupertinoModalPopup<List<String>>(
      context: context,
      builder: (_) => const _PhotoSourceWidget(),
    );

    if (fileNames == null) {
      return;
    }

    setState(() {
      // Трактуем пустой список, как команду очистить список фото
      if (fileNames.isEmpty) {
        items.clear();
      } else {
        items.addAll(fileNames);
      }
    });

    _notifyChanges();
  }

  void _removePhoto(String fileName) {
    setState(() {
      items.remove(fileName);
    });
    _notifyChanges();
  }

  void _notifyChanges() {
    widget.onChange(items);
  }
}

/// Диалог выбора источника фото.
class _PhotoSourceWidget extends StatelessWidget {
  const _PhotoSourceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: Center(
            child: Text(
              AppStrings.cancel.toUpperCase(),
              style: Theme.of(context).buttonGreen,
            ),
          ),
        ),
      ),
      actions: [
        _ActionItem(
          icon: AppIcons.camera,
          text: AppStrings.clear,
          onPressed: () => _clear(context),
        ),
        _ActionItem(
          icon: AppIcons.photo,
          text: AppStrings.photo,
          onPressed: () => _pickFromCamera(context),
        ),
        _ActionItem(
          icon: AppIcons.file,
          text: AppStrings.file,
          onPressed: () => _pickFromGallery(context),
        ),
      ],
    );
  }

  /// Очистка списка уже выбранных фото.
  void _clear(BuildContext context) {
    Navigator.of(context).pop(const <String>[]);
  }

  /// Выбор фото из галлереи.
  Future<void> _pickFromGallery(BuildContext context) async {
    final navigator = Navigator.of(context);

    final picker = ImagePicker();
    final images = await picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 75,
    );

    navigator.pop(images?.map<String>((e) => e.path).toList(growable: false));
  }

  /// Получение фото с камеры.
  Future<void> _pickFromCamera(BuildContext context) async {
    final navigator = Navigator.of(context);

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 75,
    );

    image != null ? navigator.pop(<String>[image.path]) : navigator.pop();
  }
}

/// Пунккт меню диалога.
class _ActionItem extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;

  const _ActionItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoActionSheetAction(
      onPressed: onPressed,
      child: Row(
        children: [
          SvgIcon(icon, color: theme.colorScheme.onDialog),
          spacerW12,
          Text(text, style: theme.text400OnDialog),
        ],
      ),
    );
  }
}

/// Кнопка добавления новых фото.
class _AddCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.green;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _cardSize,
        height: _cardSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(
            color: color.withOpacity(0.48),
            width: 2.0,
          ),
        ),
        child: SvgIcon(
          AppIcons.plus,
          size: _cardSize * 0.5,
          color: color,
        ),
      ),
    );
  }
}

/// Карточка фото.
class _PhotoCard extends StatelessWidget {
  final String fileName;
  final void Function(String) onNeedRemove;

  const _PhotoCard({
    Key? key,
    required this.fileName,
    required this.onNeedRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(fileName),
      direction: DismissDirection.up,
      onDismissed: (_) => _remove(),
      child: Container(
        width: _cardSize,
        height: _cardSize,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          image: DecorationImage(
            image: FileImage(File(fileName)),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.main.withOpacity(0.24),
              BlendMode.color,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, top: 4.0),
          child: GestureDetector(
            child: const SvgIcon(AppIcons.clear),
            onTap: _remove,
          ),
        ),
      ),
    );
  }

  void _remove() {
    onNeedRemove(fileName);
  }
}

const _cardSize = 72.0;
