import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/repository/network_filtered_place_repository.dart';
import 'package:places/data/rest/rest_client.dart';

/// Интерфейс репозитория для фильтрации интересных мест.
abstract class FilteredPlaceRepository {
  const factory FilteredPlaceRepository.network({
    required RestClient restClient,
  }) = NetworkFilteredPlaceRepository;

  Future<Iterable<Place>> getFiltered({required PlaceFilterRequest filter});
}
