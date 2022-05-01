import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';

/// Список категорий и соответствующих им иконок.
extension Categories on Category {
  static const Map<Category, String> _icons = {
    Category.hotel: AppIcons.hotel,
    Category.restaurant: AppIcons.restaurant,
    Category.particularPlace: AppIcons.particularPlace,
    Category.park: AppIcons.park,
    Category.museum: AppIcons.museum,
    Category.cafe: AppIcons.cafe,
  };

  static const Map<Category, String> _titles = {
    Category.hotel: AppStrings.hotel,
    Category.restaurant: AppStrings.restaurant,
    Category.particularPlace: AppStrings.particularPlace,
    Category.park: AppStrings.park,
    Category.museum: AppStrings.museum,
    Category.cafe: AppStrings.cafe,
  };

  String get icon => _icons[this]!;

  String get title => _titles[this]!;

  static List<String> get titles => _titles.values.toList(growable: false);
}
