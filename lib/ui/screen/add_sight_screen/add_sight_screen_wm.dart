import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/logger.dart';
import 'package:places/ui/res/scaffold_messenger_extension.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Новое место".
class AddSightScreenWM
    extends WidgetModel<AddSightScreen, AddSightScreenModel>
    with CommonWMMixin<AddSightScreen, AddSightScreenModel>
    implements IAddSightScreenWidgetModel {
  final _formKey = GlobalKey<FormState>();
  final _categoryKey = GlobalKey<FormFieldState<Category>>();
  final _urlsKey = GlobalKey<FormFieldState<List<String>>>();
  final _focusNodes = List.generate(4, (index) => FocusNode());
  final _data = NewSight();
  final _dataIsValid = ValueNotifier(false);
  final _dataIsSending = ValueNotifier(false);

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  GlobalKey<FormFieldState<Category>> get categoryKey => _categoryKey;

  @override
  GlobalKey<FormFieldState<List<String>>> get urlsKey => _urlsKey;

  @override
  double get loaderSize => _loaderSize;

  @override
  NewSight get data => _data;

  @override
  ValueNotifier<bool> get dataIsValid => _dataIsValid;

  @override
  ValueNotifier<bool> get dataIsSending => _dataIsSending;

  late double _loaderSize;

  AddSightScreenWM(AddSightScreenModel model) : super(model);

  @override
  void didChangeDependencies() {
    // Чтобы не ограничивать кнопки по высоте, приходится рассчитывать размера лоадера,
    // чтобы высота кнопки не "плясала" при смене текст/лоадер.
    _loaderSize = Loader.calcSizeForButton(context);
    super.didChangeDependencies();
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  FocusNode focusNode(int index) => _focusNodes[index];

  @override
  void back({bool result = false}) {
    Navigator.of(context).pop(result);
  }

  @override
  void onFormChanged() {
    dataIsValid.value = _formKey.currentState?.validate() ?? false;
  }

  @override
  void onUrlsChanged(List<String> urls) {
    _urlsKey.currentState?.didChange(urls);
  }

  @override
  Future<void> showCategoryPicker() async {
    final result = await context.pushScreen<Category>(
      AppRoutes.categories,
      args: _categoryKey.currentState?.value,
    );

    if (result != null) {
      _categoryKey.currentState?.didChange(result);
    }
  }

  @override
  void pointOnMap() {
    debugPrint('addSight.pointOnMap');
  }

  @override
  Future<void> addNewSight() async {
    dataIsSending.value = true;
    try {
      onFormChanged();
      if (dataIsValid.value) {
        _formKey.currentState?.save();
        final result = await model.addSight(_data.toSight());
        if (result) {
          back(result: true);
        }
      }
    } finally {
      dataIsSending.value = false;
    }
  }
}

/// Интерфейс WM.
abstract class IAddSightScreenWidgetModel extends ICommonWidgetModel {
  /// Ключ состояния формы.
  GlobalKey<FormState> get formKey;

  /// Ключ состояния поля Категория.
  GlobalKey<FormFieldState<Category>> get categoryKey;

  /// Ключ состояния списка фото.
  GlobalKey<FormFieldState<List<String>>> get urlsKey;

  /// Данные формы.
  NewSight get data;

  /// Состояние полноты и корректности данных формы.
  ValueNotifier<bool> get dataIsValid;

  /// Признак отправки данных на сервер.
  ValueNotifier<bool> get dataIsSending;

  /// Размер индикатора прогресса.
  double get loaderSize;

  /// Получение элемента фокуса по индксу.
  FocusNode focusNode(int index);

  /// Обработчик нажатия кнопки Назад
  void back();

  /// Обработчик изменения данных формы.
  void onFormChanged();

  /// Обработчик изменений списка фото.
  void onUrlsChanged(List<String> urls);

  /// Вызов диалога выбора категории.
  Future<void> showCategoryPicker();

  /// Обработчик нажатия на ссылку "Указать на карте".
  void pointOnMap();

  /// Обработчик нажатия на кнопку "Создать".
  Future<void> addNewSight();
}

/// Реализация WM по-умолчанию.
AddSightScreenWM defaultAddSightScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final model = AddSightScreenModel(
    appDependencies.placeInteractor,
    appDependencies.errorHandler,
  );

  return AddSightScreenWM(model);
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

/// Валидаторы текстовых полей.
abstract class Validators {
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
