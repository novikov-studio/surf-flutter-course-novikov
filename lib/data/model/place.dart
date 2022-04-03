import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    int? id,
    required double lat,
    required double lng,
    required String name,
    required List<String> urls,
    required PlaceType placeType,
    required String description,
    double? distance,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

enum PlaceType {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other,
}
