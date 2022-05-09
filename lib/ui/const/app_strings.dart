/// Строковые константы приложения
abstract class AppStrings {
  // Заголовки
  static const appTitle = 'Интересные места';
  static const listTitle = 'Список интересных\u00A0мест';
  static const favoritesTitle = 'Избранное';
  static const settingsTitle = 'Настройки';
  static const newSightTitle = 'Новое место';
  static const categoryTitle = 'Категория';
  static const mapTitle = 'Карта';

  // Названия полей
  static const categories = 'КАТЕГОРИИ';
  static const darkTheme = 'Темная тема';
  static const watchTutorial = 'Смотреть туториал';
  static const category = 'КАТЕГОРИЯ';
  static const name = 'НАЗВАНИЕ';
  static const longitude = 'ДОЛГОТА';
  static const latitude = 'ШИРОТА';
  static const description = 'ОПИСАНИЕ';
  static const yourHistory = 'ВЫ ИСКАЛИ';

  // Надписи на кнопках
  static const buildRoute = 'ПОСТРОИТЬ МАРШРУТ';
  static const doneRoute = 'ПРОЙДЕНО';
  static const schedule = 'Запланировать';
  static const reschedule = 'Перепланировать';
  static const share = 'Поделиться';
  static const addFavorites = 'В Избранное';
  static const clear = 'Очистить';
  static const cancel = 'Отмена';
  static const create = 'СОЗДАТЬ';
  static const pointOnMap = 'Указать на карте';
  static const save = 'СОХРАНИТЬ';
  static const newSight = 'НОВОЕ МЕСТО';
  static const clearHistory = 'Очистить историю';
  static const delete = 'Удалить';
  static const skip = 'Пропустить';
  static const start = 'НА СТАРТ';
  static const camera = 'Камера';
  static const photo = 'Фото';
  static const file = 'Файл';
  static const yes = 'Да';
  // ignore: prefer-correct-identifier-length
  static const no = 'Нет';

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
  static const search = 'Поиск';
  static const nothingFound = 'Ничего не найдено';
  static const tryAnotherSearch = 'Попробуйте изменить параметры поиска';
  static const errorOnInit  = 'Ошибка инициализации';
  static const errorOnInitDesc  = 'Попробуйте очистить кэш и перезапустить приложение';
  static const scheduleDate = 'Запланировать посещение';
  static const rescheduleDate = 'Перепланировать посещение';

  // Диалоги
  static const geoServiceOff = 'Служба геолокации отключена';
  static const showGeoSettings = 'Хотите открыть настройки геолокации?';
  static const geoDenied = 'Доступ к метоположению запрещен';
  static const showAppSettings = 'Открыть настройки приложения?';
  static const geoDeniedForever = 'Доступ к местоположению запрещен';

  // Ошибки
  static const error = 'Ошибка';
  static const unknownError = 'Что-то пошло не так, $tryLater';
  static const tryLater = 'попробуйте позже';
  static const connectTimeout = 'Нет связи с сервером, $tryLater';
  static const sendTimeout = 'Не удалось выполнить запрос, $tryLater';
  static const receiveTimeout = 'Сервер не отвечает, $tryLater';
  static const requestCanceled  = 'Запрос отменен';
  static const connectionRefused = 'Сервер временно недоступен, $tryLater';
  static const failedHostLookup = 'Проверьте подключение к Интернету';
  static const srvInvalidRequest = 'Сервер сообщает об ошибке';
  static const srvDuplicate = 'Объект уже сущестует';
  static const srvNotFound = 'Объект не найден';

  // Экран Избранное
  static const alreadyVisited = 'Уже посетил';
  static const myWishList = 'Хочу посетить';
  static const empty = 'Пусто';
  static const tagPlaces =
      'Отмечайте понравившиеся места, и они появятся здесь.';
  static const finishRoute = 'Завершите маршрут, чтобы место попало сюда.';

  // Экран Онбординг
  static const welcome = 'Добро пожаловать\nв Путеводитель';
  static const welcomeDetails = 'Ищи новые локации и сохраняй самые любимые.';

  static const routing = 'Построй маршрут\nи отправляйся в путь';
  static const routingDetails = 'Достигай цели максимально быстро и комфортно.';

  static const savePlaces = 'Добавляй места,\nкоторые нашёл сам';
  static const savePlacesDetails = 'Делись самыми интересными и помоги нам стать лучше!';

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
    final sDay = day.toString().padLeft(2, '0');
    final sMonth = AppStrings.months[month - 1];

    return '$sDay $sMonth $year';
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
