import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_wm.dart';
import 'package:places/ui/screen/onboarding_screen/widgets/page_indicator.dart';
import 'package:places/ui/screen/onboarding_screen/widgets/step_page.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';
import 'package:places/ui/widget/state_notifier_builder_ex.dart';

/// Экран "Онбординг".
///
/// Если передан параметр nextScreen, то при нажатии Пропустить или СТАРТ
/// происходит замена текущего экрана на указанный.
/// Если параметр nextScreen = null, при нажатии вышеуказанных кнопок
/// произойдет возврат на предыдущий экран.
class OnboardingScreen extends ElementaryWidget<IOnboardingScreenWidgetModel> {
  const OnboardingScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultOnboardingScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IOnboardingScreenWidgetModel wm) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: wm.pageController,
              children: [
                StepPage(
                  icon: AppIcons.tutorial1,
                  title: AppStrings.welcome,
                  details: AppStrings.welcomeDetails,
                  onStart: wm.start,
                ),
                StepPage(
                  icon: AppIcons.tutorial2,
                  title: AppStrings.routing,
                  details: AppStrings.routingDetails,
                  onStart: wm.start,
                ),
                StepPage(
                  icon: AppIcons.tutorial3,
                  title: AppStrings.savePlaces,
                  details: AppStrings.savePlacesDetails,
                  isLast: true,
                  onStart: wm.start,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 88.0,
            child: PageIndicator(
              pageController: wm.pageController,
              pageCount: 3,
              color: wm.theme.colorScheme.green,
            ),
          ),
          Positioned(
            right: 8.0,
            top: 32.0,
            child: StateNotifierBuilderEx<double>(
              listenableState: wm.skipButtonTransparency,
              builder: (_, value, child) {
                return Opacity(
                  opacity: value ?? 1.0,
                  child: child,
                );
              },
              child: SvgTextButton.link(
                label: AppStrings.skip,
                color: wm.theme.colorScheme.green,
                padding: const EdgeInsets.all(8.0),
                onPressed: wm.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
