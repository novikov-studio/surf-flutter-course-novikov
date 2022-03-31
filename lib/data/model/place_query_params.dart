class PlaceQueryParams {
  final int? count;
  final int? offset;
  final String? pageBy;
  final String? pageAfter;
  final String? pagePrior;
  final List<String>? sortBy;

  PlaceQueryParams(this.count, this.offset, this.pageBy, this.pageAfter, this.pagePrior, this.sortBy);
}
