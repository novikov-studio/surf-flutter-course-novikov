import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';

const TextStyle largeTitle = TextStyle(
  color: AppColors.secondary,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  height: 1.12,
);

const title = TextStyle(
  color: AppColors.secondary,
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  height: 1.2,
);

const subtitle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  height: 1.33,
);

final TextStyle subtitleInactiveBlack =
    subtitle.copyWith(color: AppColors.inactiveBlack);

const text = TextStyle(
  color: AppColors.secondary,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  height: 1.25,
);

const small = TextStyle(
  fontSize: 14.0,
  height: 1.29,
);

final TextStyle smallGreen = small.copyWith(color: AppColors.green);
final TextStyle smallSecondary = small.copyWith(color: AppColors.secondary);
final TextStyle smallSecondary2 = small.copyWith(color: AppColors.secondary2);
final TextStyle smallInactiveBlack =
    small.copyWith(color: AppColors.inactiveBlack);

const smallBold = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  height: 1.29,
);

final TextStyle smallBoldWhite = smallBold.copyWith(color: AppColors.white);
final TextStyle smallBoldSecondary =
    smallBold.copyWith(color: AppColors.secondary);

const superSmall = TextStyle(
  fontSize: 12.0,
  height: 1.33,
);

const button = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  height: 1.29,
  letterSpacing: 0.42,
);
