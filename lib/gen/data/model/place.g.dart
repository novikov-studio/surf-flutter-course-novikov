// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Place _$$_PlaceFromJson(Map<String, dynamic> json) => _$_Place(
      id: json['id'] as int?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      placeType: $enumDecode(_$PlaceTypeEnumMap, json['placeType']),
      description: json['description'] as String,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_PlaceToJson(_$_Place instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['lat'] = instance.lat;
  val['lng'] = instance.lng;
  val['name'] = instance.name;
  val['urls'] = instance.urls;
  val['placeType'] = _$PlaceTypeEnumMap[instance.placeType];
  val['description'] = instance.description;
  writeNotNull('distance', instance.distance);
  return val;
}

const _$PlaceTypeEnumMap = {
  PlaceType.temple: 'temple',
  PlaceType.monument: 'monument',
  PlaceType.park: 'park',
  PlaceType.theatre: 'theatre',
  PlaceType.museum: 'museum',
  PlaceType.hotel: 'hotel',
  PlaceType.restaurant: 'restaurant',
  PlaceType.cafe: 'cafe',
  PlaceType.other: 'other',
};
