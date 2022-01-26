import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/sight_details_text.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

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
                child: DarkenImage(url: sight.url),
              ),
              Positioned(
                left: 16.0,
                top: statusHeight + 16.0,
                // TODO(novikov): Возрат на предыдущий экран
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: AppColors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: AppColors.main,
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
              child: SightDetailsText(sight: sight),
            ),
          ),
        ],
      ),
    );
  }
}
