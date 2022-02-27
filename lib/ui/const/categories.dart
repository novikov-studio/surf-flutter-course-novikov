import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';

/// Список категорий и соответствующих им иконок.
abstract class Categories {
  static const Map<String, String> items = {
    AppStrings.hotel: AppIcons.hotel,
    AppStrings.restaurant: AppIcons.restaurant,
    AppStrings.particularPlace: AppIcons.particularPlace,
    AppStrings.park: AppIcons.park,
    AppStrings.museum: AppIcons.museum,
    AppStrings.cafe: AppIcons.cafe,
  };

  static List<String> get names => items.keys.toList(growable: false);
}
