// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/place_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PlaceQueryParamsToJson(PlaceQueryParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  writeNotNull('offset', instance.offset);
  writeNotNull('pageBy', instance.pageBy);
  writeNotNull('pageAfter', instance.pageAfter);
  writeNotNull('pagePrior', instance.pagePrior);
  writeNotNull('sortBy', instance.sortBy);
  return val;
}
