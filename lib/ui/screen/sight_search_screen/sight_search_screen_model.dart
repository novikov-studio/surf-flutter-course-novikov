import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/sight.dart';

/// Модель экрана "Поиск мест".
class SightSearchScreenModel extends ElementaryModel {
  final SearchInteractor _searchInteractor;

  SightSearchScreenModel(
    ErrorHandler errorHandler,
    this._searchInteractor,
  ) : super(errorHandler: errorHandler);

  Future<List<Sight>> search(String pattern) async =>
      _searchInteractor.searchPlaces(name: pattern);

  Future<List<String>> loadHistory() async =>
      _searchInteractor.getHistory();

  Future<void> addToHistory(String value) async =>
      _searchInteractor.addToHistory(value);

  Future<void> removeFromHistory(String value) async =>
      _searchInteractor.removeFromHistory(value);

  Future<void> clearHistory() async => _searchInteractor.clearHistory();
}
