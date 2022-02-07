import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/sight_details_text.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  @override
  void initState() {
    super.initState();
    // Изменяем системный StatusBar
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Theme.of(context).updateSystemStatusBar(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    // Убираем нижний системный NavigationBar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: DarkenImage(url: widget.sight.url),
              ),
              Positioned(
                left: 16.0,
                top: statusHeight + 16.0,
                // TODO(novikov): Возрат на предыдущий экран
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          spacerH24,
          Expanded(
            child: SingleChildScrollView(
              child: SightDetailsText(sight: widget.sight),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Возвращаем нижний системный NavigationBar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }
}
