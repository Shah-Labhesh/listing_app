import 'package:flutter/material.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightUnitBg,
    selectedItemColor: AppColors.lightHighlightPrimary,
    unselectedItemColor: AppColors.lightBasePrimary,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Hoves-medium',
      fontSize: FontSizeManager.f16,
      color: AppColors.lightBasePrimary,
      letterSpacing: 0.5,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: FontSizeManager.f16,
      fontFamily: 'Hoves-medium',
      color: AppColors.lightBasePrimary,
      letterSpacing: 0.5,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkUnitBg,
    selectedItemColor: AppColors.darkPurpure,
    unselectedItemColor: AppColors.darkBaseSecondaryGray2,
    selectedLabelStyle: TextStyle(
      fontSize: FontSizeManager.f16,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBasePrimaryGray1,
      letterSpacing: 0.5,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: FontSizeManager.f16,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBaseSecondaryGray2,
      letterSpacing: 0.5,
    ),
  ),
);