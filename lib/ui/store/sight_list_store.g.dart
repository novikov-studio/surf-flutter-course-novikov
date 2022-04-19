// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SightListStore on SightListBase, Store {
  final _$getSightsAsyncAction = AsyncAction('SightListBase.getSights');

  @override
  Future<void> getSights({bool hidden = true}) {
    return _$getSightsAsyncAction.run(() => super.getSights(hidden: hidden));
  }

  final _$SightListBaseActionController =
      ActionController(name: 'SightListBase');

  @override
  void setFilter(Filter value) {
    final _$actionInfo = _$SightListBaseActionController.startAction(
        name: 'SightListBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$SightListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
