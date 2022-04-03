import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_query_params.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/data/rest/dio_rest_client.dart';
import 'package:places/data/rest/rest_exception.dart';

void main() {
  const baseUrl = 'https://test-backend-flutter.surfstudio.ru';

  // Тестовый объект
  const place = Place(
    name: 'TestName',
    lat: 50.0,
    lng: 50.0,
    urls: ['url1', 'url2'],
    placeType: PlaceType.other,
    description: 'TestDescription',
  );

  group('Real tests', () {
    // Создаем экземпляр репозитория
    final repository = NetworkPlaceRepository(
      restClient: DioRestClient(baseUrl: baseUrl),
    );

    test(
      'Test getAll API',
      () async {
        final result =
            await repository.getAll(params: PlaceQueryParams(count: 1));
        expect(result, isA<Iterable<Place>>());
        expect(result.length, 1);
      },
    );

    test(
      'Test CRUD API',
      () async {
        // Проверка создания
        final createdPlace = await repository.create(place: place);
        expect(createdPlace, place.copyWith(id: createdPlace.id));

        // Проверка чтения
        final readPlace = await repository.getOne(id: createdPlace.id!);
        expect(readPlace, createdPlace);

        // Проверка обновления
        final modifiedPlace = createdPlace.copyWith(name: 'UpdatedName');
        final updatedPlace = await repository.update(
          place: modifiedPlace,
        );
        expect(updatedPlace, modifiedPlace);

        // Проверка удаления
        await repository.delete(id: createdPlace.id!);
      },
    );

    test(
      'Test error 404',
      () async {
        Future<void> create() async {
          await repository.getOne(id: -1);
        }

        await expectLater(
          create,
          throwsA(isA<SrvNotFoundException>()),
        );
      },
    );

    test(
      'Test error 409',
      () async {
        Future<void> create() async {
          await repository.create(place: place.copyWith(id: 0));
        }

        await expectLater(
          create,
          throwsA(isA<SrvDuplicateException>()),
        );
      },
    );
  });

  group(
    'Mock tests',
    () {
      final dioRestClient = DioRestClient(baseUrl: baseUrl);
      final dioAdapter = DioAdapter(dio: dioRestClient.dio);
      final repository = NetworkPlaceRepository(
        restClient: dioRestClient,
      );

      test(
        'Test error 400',
        () async {
          dioAdapter.onGet('/place/0', (server) => server.reply(400, null));

          Future<void> getOne() async {
            await repository.getOne(id: 0);
          }

          await expectLater(
            getOne(),
            throwsA(isA<SrvInvalidRequestException>()),
          );
        },
      );
    },
  );
}
