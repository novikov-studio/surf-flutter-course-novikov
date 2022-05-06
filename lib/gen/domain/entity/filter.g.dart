// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../domain/entity/filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Filter _$$_FilterFromJson(Map<String, dynamic> json) => _$_Filter(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CategoryEnumMap, e))
          .toSet(),
      minRadius: (json['minRadius'] as num?)?.toDouble(),
      maxRadius: (json['maxRadius'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_FilterToJson(_$_Filter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('categories',
      instance.categories?.map((e) => _$CategoryEnumMap[e]).toList());
  writeNotNull('minRadius', instance.minRadius);
  writeNotNull('maxRadius', instance.maxRadius);
  return val;
}

const _$CategoryEnumMap = {
  Category.hotel: 'hotel',
  Category.restaurant: 'restaurant',
  Category.particularPlace: 'particularPlace',
  Category.park: 'park',
  Category.museum: 'museum',
  Category.cafe: 'cafe',
};
