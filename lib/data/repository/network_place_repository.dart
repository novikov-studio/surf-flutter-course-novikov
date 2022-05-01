import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_query_params.dart';
import 'package:places/data/model/rest_deserializer.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/domain/repository/place_repository.dart';

/// Сетевая реализаия интерфейса [PlaceRepository].
class NetworkPlaceRepository implements PlaceRepository {
  final RestClient _restClient;

  const NetworkPlaceRepository({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Place> create({required Place place}) async {
    final dynamic res = await _restClient.post('/place', data: place.toJson());

    return RestDeserializer.map(res, Place.fromJson);
  }

  @override
  Future<void> delete({required int id}) async {
    await _restClient.delete('/place/$id');
  }

  @override
  Future<Iterable<Place>> getAll({PlaceQueryParams? params}) async {
    final dynamic res = await _restClient.get(
      '/place',
      params: params?.toJson(),
    );

    return RestDeserializer.list<Place>(res, Place.fromJson);
  }

  @override
  Future<Place> getOne({required int id}) async {
    final dynamic res = await _restClient.get('/place/$id');

    return RestDeserializer.map(res, Place.fromJson);
  }

  @override
  Future<Place> update({required Place place}) async {
    assert(place.id != null);

    final dynamic res = await _restClient.put(
      '/place/${place.id}',
      data: place.copyWith(id: null).toJson(),
    );

    return RestDeserializer.map(res, Place.fromJson);
  }
}
