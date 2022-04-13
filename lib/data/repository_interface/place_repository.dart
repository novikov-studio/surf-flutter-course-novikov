import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_query_params.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/data/rest/rest_client.dart';

/// Интерфейс репозитория интересных мест.
abstract class PlaceRepository {
  const factory PlaceRepository.network({
    required RestClient restClient,
  }) = NetworkPlaceRepository;

  Future<Iterable<Place>> getAll({PlaceQueryParams? params});

  Future<Place> create({required Place place});

  Future<Place> getOne({required int id});

  Future<Place> update({required Place place});

  Future<void> delete({required int id});
}
