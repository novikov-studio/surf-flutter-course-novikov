import 'package:json_annotation/json_annotation.dart';
import 'package:places/data/model/place.dart';

part 'place_filter_request.g.dart';

/// Модель данных с параметрами фильтра.
@JsonSerializable(includeIfNull: false, createFactory: false)
class PlaceFilterRequest {
  final double? lat;
  final double? lng;
  final double? radius;
  final Set<PlaceType>? typeFilter;
  final String? nameFilter;

  PlaceFilterRequest({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  }) : assert((lat == null) && (lng == null) && (radius == null) ||
            (lat != null) && (lng != null) && (radius != null));

  Map<String, dynamic> toJson() => _$PlaceFilterRequestToJson(this);
}
