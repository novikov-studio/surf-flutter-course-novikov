import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('res/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MyApp());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      // home: MyFirstWidget(),
      home: const MySecondWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  int counter = 0;

  MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(counter++);
    print(context.runtimeType);
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }

// Error: Undefined name 'context'
// Type getContextType() => context.runtimeType;
}

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    print(counter++);
    print(getContextType());
    return Container(
      child: const Center(
        child: Text('Hello 2'),
      ),
    );
  }

  Type getContextType() => context.runtimeType;
}
