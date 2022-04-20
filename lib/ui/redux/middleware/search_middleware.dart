import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:redux/redux.dart';

/// Асинхронный обработчик событий поиска.
class SearchMiddleware implements MiddlewareClass<AppState> {
  final SearchInteractor _searchInteractor;

  SearchMiddleware({required SearchInteractor searchInteractor})
      : _searchInteractor = searchInteractor;

  @override
  // ignore: avoid_annotating_with_dynamic
  dynamic call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is! SearchAction) {
      return next.call(action);
    }

    action.maybeWhen(
      start: (pattern) {
        _searchInteractor
            .searchPlaces(name: pattern)
            .then<dynamic>(
              (sights) => store.dispatch(SearchAction.result(sights)),
            )
            // ignore: avoid_types_on_closure_parameters
            .catchError((Object error, StackTrace stacktrace) =>
                store.dispatch(SearchAction.error(error)));
      },
      // ignore: no-empty-block
      orElse: () {},
    );

    next(action);
  }
}
