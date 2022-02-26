import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/location.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/buttons/link_button.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/text_form_field_ex.dart';

typedef OnSightAdd = void Function(Sight sight);

/// Экран "Новое место".
class AddSightScreen extends StatefulWidget {
  final OnSightAdd onSightAdd;

  const AddSightScreen({Key? key, required this.onSightAdd}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(4, (index) => FocusNode());
  final _data = NewSight();
  final _isValid = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.newSight),
        leadingWidth: 60.0,
        leading: LinkButton(
          label: AppStrings.cancel,
          color: theme.colorScheme.secondary2,
          onPressed: () => Navigator.pop(context),
        ),
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
                  child: Column(children: [
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
                      child: LinkButton(
                        label: AppStrings.pointOnMap,
                        color: theme.colorScheme.green,
                        onPressed: _onPointOnMap,
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
                  ]),
                ),
              ),
              spacerH12,
              ValueListenableBuilder<bool>(
                valueListenable: _isValid,
                builder: (_, value, child) => ElevatedButton(
                  onPressed: value ? _onCreateButtonPressed : null,
                  child: child,
                ),
                child: const Text(AppStrings.create),
              ),
              spacerH8,
            ],
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

  void _onCreateButtonPressed() {
    _onFormChanged();
    if (_isValid.value) {
      _formKey.currentState?.save();

      // TODO(novikov): Добавить выбор категории и изображений
      _data
        ..type = ''
        ..url = '';

      widget.onSightAdd(_data.toSight());
    }
  }

  void _onPointOnMap() {
    Utils.logButtonPressed('addSight.pointOnMap');
  }

  void _onFormChanged() {
    _isValid.value = _formKey.currentState?.validate() ?? false;
  }
}

/// Виджет добавляет текстовый заголовок [label] над [child].
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textInactiveBlack,
        ),
        spacerH12,
        child,
      ],
    );
  }
}

/// Валидаторы текстовых полей.
abstract class _Validators {
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
  String? type;
  String? url;

  @override
  String toString() {
    return 'name: $name\n'
        'location: $latitude, $longitude\n'
        'type: $type\n'
        'details: $details';
  }

  Sight toSight() => Sight(
        name: name!,
        location: Location(
          latitude: latitude!,
          longitude: longitude!,
        ),
        type: type!,
        details: details,
        url: url!,
      );
}
