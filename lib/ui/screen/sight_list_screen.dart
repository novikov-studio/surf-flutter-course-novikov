import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Экран "Список мест"
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  static const _largeTitle = TextStyle(
    color: AppColors.secondary,
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
          style: _largeTitle,
        ),
        backgroundColor: AppColors.background,
        elevation: 0.0,
        toolbarHeight: 120.0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var sight in mocks)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: SightCard(
                  sight: sight,
                  onLikeToggle: () => _onLikeToggle(sight),
                  onTap: () => _onCardTap(sight),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onLikeToggle(Sight _) {
    // TODO(novikov): реализовать обработку [onLikeToggle]
  }

  void _onCardTap(Sight _) {
    // TODO(novikov): реализовать обработку [onCardTap]
  }
}
