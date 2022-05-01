import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/model/rest_deserializer.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/domain/repository/filtered_place_repository.dart';

/// Сетевая реализаия интерфейса [FilteredPlaceRepository].
class NetworkFilteredPlaceRepository implements FilteredPlaceRepository {
  final RestClient _restClient;

  const NetworkFilteredPlaceRepository({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Iterable<Place>> getFiltered({
    required PlaceFilterRequest filter,
  }) async {
    final dynamic res = await _restClient.post(
      '/filtered_places',
      data: filter.toJson(),
    );

    return RestDeserializer.list<Place>(res, Place.fromJson);
  }
}
