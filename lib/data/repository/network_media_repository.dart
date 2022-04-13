import 'package:places/data/repository_interface/media_repository.dart';
import 'package:places/data/rest/rest_client.dart';

/// Сетевая реализаия интерфейса [MediaRepository].
class NetworkMediaRepository implements MediaRepository {
  final RestClient _restClient;

  const NetworkMediaRepository({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Map<String, String>> upload({
    required Map<String, List<int>> files,
  }) async {
    return _restClient.upload('/upload_file', files: files);
  }
}
