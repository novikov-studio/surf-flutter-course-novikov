import 'package:json_annotation/json_annotation.dart';

part '../../gen/data/model/place_query_params.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class PlaceQueryParams {
  final int? count;
  final int? offset;
  final String? pageBy;
  final String? pageAfter;
  final String? pagePrior;
  final List<String>? sortBy;

  PlaceQueryParams({
    this.count,
    this.offset,
    this.pageBy,
    this.pageAfter,
    this.pagePrior,
    this.sortBy,
  }) : assert(pageBy == null || pageAfter != null || pagePrior != null);

  Map<String, dynamic> toJson() => _$PlaceQueryParamsToJson(this);
}
