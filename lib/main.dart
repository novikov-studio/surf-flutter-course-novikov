import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/app.dart';
import 'package:places/data/rest/rest_client.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('res/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const App());

  final restClient = RestClient.getInstance(
    baseUrl: 'http://jsonplaceholder.typicode.com',
  );

  restClient.get<String>('/users').then(
        (result) => debugPrint('RESULT: $result'),
        // ignore: avoid_types_on_closure_parameters
        onError: (Object error) => debugPrint('$error'),
      );
}
