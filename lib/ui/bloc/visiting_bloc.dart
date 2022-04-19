import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/errors.dart';

part 'visiting_bloc.freezed.dart';

/// Менеджер состояния экрана "Избранное".
class VisitingBloc extends Bloc<VisitingBlocEvent, VisitingBlocState> {
  final PlaceInteractor _placeInteractor;

  VisitingBloc({required PlaceInteractor placeInteractor})
      : _placeInteractor = placeInteractor,
        super(const LoadingVisitingBlocState()) {
    on<VisitingBlocEvent>((event, emit) async {
      await event.map<Future<void>>(
        load: (event) => _load(event, emit),
        reorder: (event) => _reorder(event, emit),
      );
    });
  }

  /// Обработчик события [LoadVisitingBlocEvent].
  Future<void> _load(
    LoadVisitingBlocEvent event,
    Emitter<VisitingBlocState> emitter,
  ) async {
    try {
      if (!event.hidden) {
        // Индикация загрузки
        emitter(const VisitingBlocState.loading());
      }

      // Запрос данных
      final res = await _placeInteractor.getFavorites();
      // TODO(novikov): Когда favorites будут храниться в БД, List.unmodifiable можно попробовать убрать
      emitter(VisitingBlocState.done(List.unmodifiable(res)));
    } on Object catch (e) {
      // Обработка ошибок
      emitter(
        VisitingBlocState.error(
          message: Errors.humanReadableText(e),
          source: ErrorSource.load,
          critical: Errors.isCritical(e),
        ),
      );
    }
  }

  /// Обработчик события [ReorderVisitingBlocEvent].
  Future<void> _reorder(
    ReorderVisitingBlocEvent event,
    Emitter<VisitingBlocState> emitter,
  ) async {
    try {
      // Выполнение запроса
      await _placeInteractor.reorderInFavorites(
        sourceId: event.sourceId,
        insertBeforeId: event.insertBeforeId,
      );
    } on Object catch (e) {
      // Обработка ошибок
      emitter(
        VisitingBlocState.error(
          message: Errors.humanReadableText(e),
          source: ErrorSource.reorder,
          critical: Errors.isCritical(e),
        ),
      );
    } finally {
      add(const VisitingBlocEvent.load());
    }
  }
}

@freezed
class VisitingBlocEvent with _$VisitingBlocEvent {
  const VisitingBlocEvent._();

  /// Загрузить список "Избранное".
  const factory VisitingBlocEvent.load({@Default(true) bool hidden}) =
      LoadVisitingBlocEvent;

  /// Переместить элемент в списке.
  const factory VisitingBlocEvent.reorder({
    required int sourceId,
    int? insertBeforeId,
  }) = ReorderVisitingBlocEvent;
}

@freezed
class VisitingBlocState with _$VisitingBlocState {
  const VisitingBlocState._();

  /// Идет загрузка.
  const factory VisitingBlocState.loading() = LoadingVisitingBlocState;

  /// Загрузка успешно завершена.
  const factory VisitingBlocState.done(SightList sights) =
      DoneVisitingBlocState;

  /// Ошибка загрузки.
  const factory VisitingBlocState.error({
    required String message,
    required ErrorSource source,
    required bool critical,
  }) = ErrorVisitingBlocState;
}

enum ErrorSource { load, reorder }
