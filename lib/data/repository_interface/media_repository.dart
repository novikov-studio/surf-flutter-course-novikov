import 'package:places/data/repository/network_media_repository.dart';
import 'package:places/data/rest/rest_client.dart';

/// Интерфейс репозитория медиафайлов.
abstract class MediaRepository {
  const factory MediaRepository.network({
    required RestClient restClient,
  }) = NetworkMediaRepository;

  Future<Map<String, String>> upload({required Map<String, List<int>> files});
}
