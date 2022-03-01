/// Строковые константы приложения
abstract class AppStrings {
  // Заголовки
  static const listTitle = 'Список\nинтересных мест';
  static const favoritesTitle = 'Избранное';
  static const settingsTitle = 'Настройки';
  static const newSightTitle = 'Новое место';
  static const categoryTitle = 'Категория';

  // Названия полей
  static const categories = 'КАТЕГОРИИ';
  static const darkTheme = 'Темная тема';
  static const watchTutorial = 'Смотреть туториал';
  static const category = 'КАТЕГОРИЯ';
  static const name = 'НАЗВАНИЕ';
  static const longitude = 'ДОЛГОТА';
  static const latitude = 'ШИРОТА';
  static const description = 'ОПИСАНИЕ';

  // Надписи на кнопках
  static const buildRoute = 'ПОСТРОИТЬ МАРШРУТ';
  static const doneRoute = 'ПРОЙДЕНО';
  static const schedule = 'Запланировать';
  static const share = 'Поделиться';
  static const addFavorites = 'В Избранное';
  static const clear = 'Очистить';
  static const cancel = 'Отмена';
  static const create = 'СОЗДАТЬ';
  static const pointOnMap = 'Указать на карте';
  static const save = 'СОХРАНИТЬ';
  static const newSight = 'НОВОЕ МЕСТО';

  // Категории
  static const hotel = 'Отель';
  static const restaurant = 'Ресторан';
  static const particularPlace = 'Особое место';
  static const park = 'Парк';
  static const museum = 'Музей';
  static const cafe = 'Кафе';

  // Сообщения
  static const imageLoadingError = 'Ошибка загрузки изображения';
  static const requiredField = 'Заполните поле';
  static const numberRequired = 'Введите число';
  static const enterString = 'Введите строку';
  static const enterText = 'Введите текст';
  static const enterNumber = 'Введите число';
  static const notChosen = 'Не выбрано';

  // Экран Избранное
  static const alreadyVisited = 'Уже посетил';
  static const myWishList = 'Хочу посетить';
  static const empty = 'Пусто';
  static const tagPlaces =
      'Отмечайте понравившиеся места, и они появятся здесь.';
  static const finishRoute = 'Завершите маршрут, чтобы место попало сюда.';

  static const months = [
    'янв.',
    'фев.',
    'мар.',
    'апр.',
    'мар.',
    'июн.',
    'июл.',
    'авг.',
    'сен.',
    'окт.',
    'ноя.',
    'дек.',
  ];

  // Экран Фильтр
  static const distance = 'Расстояние';

  // Составные строки
  static String scheduledFor(DateTime date) =>
      _scheduledFor(date.toDateOnlyString());

  static String visitedOn(DateTime date) => _visitedOn(date.toDateOnlyString());

  static String distanceRange(double start, double end) =>
      _distanceRange(
        start._toSmartUnits(
          omitUnits: start >= 1 && end >= 1 || start < 1 && end < 1,
        ),
        end._toSmartUnits(),
      );

  static String showFilterResults(int count) => 'ПОКАЗАТЬ ($count)';

  static String allowedRange(double start, double end) =>
      _allowedRange(start.toStringNormalized(), end.toStringNormalized());

  // Внутренние
  static String _scheduledFor(String date) => 'Запланировано на $date';

  static String _visitedOn(String date) => 'Цель достигнута $date';

  static String _distanceRange(String start, String end) => 'от $start до $end';

  static String _allowedRange(String start, String end) =>
      'Допустимо: $start .. $end';
}

extension DateTimeExt on DateTime {
  /// Перевод в строку вида: "dd MMM yyyy"
  String toDateOnlyString() {
    final _day = day.toString().padLeft(2, '0');
    final _month = AppStrings.months[month - 1];

    return '$_day $_month $year';
  }
}

extension DoubleExt on double {
  /// Перевод в строку вида ##.#
  String toStringNormalized() {
    final res = toStringAsFixed(1);

    return res.endsWith('.0') ? res.substring(0, res.length - 2) : res;
  }

  /// Отображает значение в метрах (если < 1) или километрах (если >= 1)
  String _toSmartUnits({bool omitUnits = false}) {
    final units = omitUnits ? ['', ''] : [' м', ' км'];

    return this < 1
        ? '${(this * 1000).toStringAsFixed(0)}${units.first}'
        : '${toStringNormalized()}${units.last}';
  }
}
