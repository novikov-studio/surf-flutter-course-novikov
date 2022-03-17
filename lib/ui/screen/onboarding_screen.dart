import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';

/// Экран "Онбординг".
class OnboardingScreen extends StatefulWidget {
  final VoidCallback onStart;

  const OnboardingScreen({Key? key, required this.onStart}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: PageView(
              controller: _controller,
              children: [
                _StepPage(
                  icon: AppIcons.tutorial1,
                  title: AppStrings.welcome,
                  details: AppStrings.welcomeDetails,
                  onStart: widget.onStart,
                ),
                _StepPage(
                  icon: AppIcons.tutorial2,
                  title: AppStrings.routing,
                  details: AppStrings.routingDetails,
                  onStart: widget.onStart,
                ),
                _StepPage(
                  icon: AppIcons.tutorial3,
                  title: AppStrings.savePlaces,
                  details: AppStrings.savePlacesDetails,
                  isLast: true,
                  onStart: widget.onStart,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 88.0,
            child: _PageIndicator(
              pageController: _controller,
              pageCount: 3,
              color: Theme.of(context).colorScheme.green,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Виджет для отображения шагов онбординга.
class _StepPage extends StatelessWidget {
  final String icon;
  final String title;
  final String details;
  final bool isLast;
  final VoidCallback onStart;

  const _StepPage({
    Key? key,
    required this.icon,
    required this.title,
    required this.details,
    required this.onStart,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: isLast
          ? AppBar(automaticallyImplyLeading: false)
          : SimpleAppBar(
              trailingText: AppStrings.skip,
              trailingOnTap: onStart,
            ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 104.0,
                height: 104.0,
                color: theme.colorScheme.onBackground,
              ),
              spacerH48,
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.titleOnBackground,
              ),
              spacerH8,
              Text(
                details,
                textAlign: TextAlign.center,
                style: theme.smallSecondary2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLast
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                child: const Text(AppStrings.start),
                onPressed: onStart,
              ),
            )
          : null,
    );
  }
}

/// Индикатор перехода по страницам.
class _PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color color;

  const _PageIndicator({
    Key? key,
    required this.pageController,
    required this.pageCount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (_, child) {
        // TODO(novikov): Добавить анимацию
        final pageIndex = pageController.page?.floor() ?? 0;

        return Row(
          children: List.generate(
            pageCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: index == pageIndex ? 24 : 8.0,
                  height: 8.0,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: color,
        ),
      ),
    );
  }
}
