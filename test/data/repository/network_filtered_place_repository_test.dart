import 'package:flutter_test/flutter_test.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/repository/network_filtered_place_repository.dart';
import 'package:places/data/rest/dio_rest_client.dart';

void main() {
  const baseUrl = 'https://test-backend-flutter.surfstudio.ru';

  group(
    'Real tests',
    () {
      // Создаем экземпляр репозитория
      final repository = NetworkFilteredPlaceRepository(
        restClient: DioRestClient(baseUrl: baseUrl),
      );

      test(
        'Test Filter API',
        () async {
          final result = await repository.getFiltered(
            filter: PlaceFilterRequest(
              lat: 10.1,
              lng: 10.1,
              radius: 1.1,
              typeFilter: {PlaceType.hotel},
              nameFilter: 'test',
            ),
          );
          expect(result, isA<Iterable<Place>>());
        },
      );
    },
  );
}
