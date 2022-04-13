import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/list_picker.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/add_sight_photos.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';
import 'package:places/ui/widget/controls/text_form_field_ex.dart';

/// Экран "Новое место".
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeKey = GlobalKey<FormFieldState<Category>>();
  final _urlsKey = GlobalKey<FormFieldState<List<String>>>();
  final _focusNodes = List.generate(4, (index) => FocusNode());
  final _data = NewSight();
  final _isValid = ValueNotifier(false);
  late double _loaderSize;
  bool _isProcessing = false;

  @override
  void didChangeDependencies() {
    // Чтобы не ограничивать кнопки по высоте, приходится рассчитывать размера лоадера,
    // чтобы высота кнопки не "плясала" при смене текст/лоадер.
    _loaderSize = Loader.calcSizeForButton(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AbsorbPointer(
      absorbing: _isProcessing,
      child: Scaffold(
        appBar: SimpleAppBar(
          title: AppStrings.newSightTitle,
          leadingText: AppStrings.cancel,
          leadingOnTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: _onFormChanged,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        spacerH24,
                        FormField<List<String>>(
                          key: _urlsKey,
                          builder: (field) => AddSightPhotos(
                            initialValue: field.value,
                            onChange: _onUrlsChanged,
                          ),
                          initialValue: _data.urls,
                          validator: _Validators.checkListNotEmpty,
                          onSaved: (value) => _data.urls = value ?? <String>[],
                        ),
                        spacerH24,
                        _LabeledField(
                          label: AppStrings.category,
                          usePadding: false,
                          child: FormField<Category>(
                            key: _typeKey,
                            builder: (field) => ListTile(
                              title: Text(
                                field.value?.title ?? AppStrings.notChosen,
                                style: field.isValid
                                    ? theme.textTheme.text400
                                    : theme.text400Secondary2,
                              ),
                              trailing: const SvgIcon(AppIcons.view),
                              contentPadding: EdgeInsets.zero,
                              onTap: _showCategoryPicker,
                            ),
                            initialValue: _data.type,
                            validator: _Validators.checkNotNull,
                            onSaved: (value) => _data.type = value,
                          ),
                        ),
                        spacerH12,
                        _LabeledField(
                          label: AppStrings.name,
                          child: TextFormFieldEx(
                            hintText: AppStrings.enterString,
                            validator: _Validators.checkNotEmpty,
                            onSaved: (value) => _data.name = value,
                            focusNode: _focusNodes.first,
                            nextFocusNode: _focusNodes[1],
                          ),
                        ),
                        spacerH12,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _LabeledField(
                                label: AppStrings.latitude,
                                child: TextFormFieldEx(
                                  hintText: AppStrings.enterNumber,
                                  validator: _Validators.checkLatitude,
                                  onSaved: (value) =>
                                      _data.latitude = double.parse(value!),
                                  focusNode: _focusNodes[1],
                                  nextFocusNode: _focusNodes[2],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: true,
                                    decimal: true,
                                  ),
                                ),
                              ),
                            ),
                            spacerW16,
                            Expanded(
                              child: _LabeledField(
                                label: AppStrings.longitude,
                                child: TextFormFieldEx(
                                  hintText: AppStrings.enterNumber,
                                  validator: _Validators.checkLongitude,
                                  onSaved: (value) =>
                                      _data.longitude = double.parse(value!),
                                  focusNode: _focusNodes[2],
                                  nextFocusNode: _focusNodes[3],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: true,
                                    decimal: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Transform.translate(
                            offset: const Offset(-8.0, 0),
                            child: SvgTextButton.link(
                              label: AppStrings.pointOnMap,
                              color: theme.colorScheme.green,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              onPressed: _onPointOnMap,
                            ),
                          ),
                        ),
                        spacerH12,
                        _LabeledField(
                          label: AppStrings.description,
                          child: TextFormFieldEx(
                            hintText: AppStrings.enterText,
                            onSaved: (value) => _data.details =
                                (value?.isNotEmpty ?? false) ? value : null,
                            focusNode: _focusNodes[3],
                            minLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spacerH12,
                ValueListenableBuilder<bool>(
                  valueListenable: _isValid,
                  builder: (_, isValid, child) => ElevatedButton(
                    onPressed: isValid ? _onCreateButtonPressed : null,
                    child: child,
                  ),
                  child: _isProcessing
                      ? Loader(size: _loaderSize)
                      : const Text(AppStrings.create),
                ),
                spacerH8,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  /// Обработчик нажатия на кнопку "Создать".
  Future<void> _onCreateButtonPressed() async {
    _onFormChanged();
    if (_isValid.value) {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      try {
        _formKey.currentState?.save();
        _inProcess(true);
        await context.placeInteractor.addNew(sight: _data.toSight());
        navigator.pop(true);
      } on Exception catch (e, stacktrace) {
        debugPrint('$e, $stacktrace');
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(AppStrings.tryLater),
          ),
        );
      } finally {
        _inProcess(false);
      }
    }
  }

  void _inProcess(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  /// Вызов диалога выбора категории.
  Future<void> _showCategoryPicker() async {
    final result = await Navigator.of(context).push<Category>(
      MaterialPageRoute(
        builder: (_) => ListPicker<Category>(
          title: AppStrings.categoryTitle,
          items: Category.values,
          names: Categories.titles,
          initialValue: _typeKey.currentState?.value,
        ),
      ),
    );

    if (result != null) {
      _typeKey.currentState?.didChange(result);
    }
  }

  /// Callback на изменение списка фото.
  void _onUrlsChanged(List<String> value) {
    _urlsKey.currentState?.didChange(value);
  }

  /// Обработчик нажатия на ссылку "Указать на карте".
  void _onPointOnMap() {
    debugPrint('addSight.pointOnMap');
  }

  /// Callback на изменение данных формы.
  void _onFormChanged() {
    _isValid.value = _formKey.currentState?.validate() ?? false;
  }
}

/// Виджет добавляет текстовый заголовок [label] над [child].
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool usePadding;

  const _LabeledField({
    Key? key,
    required this.label,
    required this.child,
    this.usePadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).superSmallInactiveBlack,
        ),
        if (usePadding) spacerH12,
        child,
      ],
    );
  }
}

/// Валидаторы текстовых полей.
abstract class _Validators {
  static String? checkListNotEmpty<T>(List<T>? list) =>
      (list?.isEmpty ?? true) ? AppStrings.requiredField : null;

  static String? checkNotNull<T>(T? value) =>
      value == null ? AppStrings.requiredField : null;

  static String? checkNotEmpty(String? text) =>
      (text?.isEmpty ?? true) ? AppStrings.requiredField : null;

  static String? checkLatitude(String? text) => _checkRange(text, -90, 90);

  static String? checkLongitude(String? text) => _checkRange(text, -180, 180);

  static String? _checkRange(String? text, double start, double end) {
    final res = checkNotEmpty(text);

    // Проверка на пустоту
    if (res != null) {
      return res;
    }

    // Проверка на число
    final value = double.tryParse(text!);
    if (value == null) {
      return AppStrings.numberRequired;
    }

    // Проверка на диапазон
    if (value < start || value > end) {
      return AppStrings.allowedRange(start, end);
    }

    return null;
  }
}

/// Класс для хранения введенных пользователем значений.
class NewSight {
  String? name;
  double? latitude;
  double? longitude;
  String? details;
  Category? type;
  List<String> urls = <String>[];

  @override
  String toString() {
    return 'name: $name\n'
        'location: $latitude, $longitude\n'
        'type: $type\n'
        'details: $details';
  }

  Sight toSight() => Sight(
        id: 0,
        name: name!,
        location: Location(
          latitude: latitude!,
          longitude: longitude!,
        ),
        type: type!,
        details: details,
        urls: urls,
      );
}
