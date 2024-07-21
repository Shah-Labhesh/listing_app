import 'package:flutter/material.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.lightBg,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    onPrimary: AppColors.lightGreen,
    onPrimaryContainer: AppColors.lightBg,
    brightness: Brightness.light,

    // cupertino switch
    surfaceContainer: AppColors.lightBg,
    inversePrimary: AppColors.lightDash,
  ),
  hoverColor: AppColors.lightBlack,
  highlightColor: AppColors.lightBg,
  dividerColor: AppColors.lightBg,
  cardColor: AppColors.lightUnitBg,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: FontSizeManager.f24,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightBasePrimary,
      ),
      titleMedium: TextStyle(
        fontSize: FontSizeManager.f14,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightBasePrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: FontSizeManager.f16,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightBasePrimary,
      ),
      labelMedium: TextStyle(
        fontSize: FontSizeManager.f14,
        fontFamily: 'Hoves-regular',
        color: AppColors.lightHighlightPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: FontSizeManager.f12,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightBaseSecondary,
      ),
      headlineMedium: TextStyle(
        fontSize: FontSizeManager.f16,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightGreen,
      ),
      headlineSmall: TextStyle(
        fontSize: FontSizeManager.f14,
        fontFamily: 'Hoves-medium',
        color: AppColors.lightBaseSecondary,
      ),
      displaySmall: TextStyle(
        fontSize: FontSizeManager.f12,
        fontFamily: 'Hoves-regular',
        color: AppColors.lightError,
      )),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.lightUnitBg,
    closeIconColor: AppColors.lightGreen,
    contentTextStyle: TextStyle(
      fontSize: FontSizeManager.f14,
      color: AppColors.lightBasePrimary,
      fontFamily: 'Hoves-regular',
    ),
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

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.darkBg,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    onPrimary: AppColors.darkGreen,
    onPrimaryContainer: AppColors.darkBg,
    brightness: Brightness.dark,

    // cupertino switch
    surfaceContainer: AppColors.darkBg,

    inversePrimary: AppColors.darkDash,
  ),
  hoverColor: AppColors.darkDash,
  highlightColor: AppColors.darkWhite,
  dividerColor: AppColors.darkBg,
  cardColor: AppColors.darkUnitBg,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: FontSizeManager.f12,
      fontFamily: 'Hoves-regular',
      color: AppColors.darkError,
    ),
    titleLarge: TextStyle(
      fontSize: FontSizeManager.f24,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBasePrimaryGray1,
    ),
    titleMedium: TextStyle(
      fontSize: FontSizeManager.f14,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBasePrimaryGray1,
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizeManager.f16,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBasePrimaryGray1,
    ),
    labelMedium: TextStyle(
      fontSize: FontSizeManager.f14,
      fontFamily: 'Hoves-regular',
      color: AppColors.darkHighlightPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: FontSizeManager.f12,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkBaseSecondaryGray2,
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizeManager.f16,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkGreen,
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizeManager.f14,
      fontFamily: 'Hoves-medium',
      color: AppColors.darkStroke,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.darkUnitBg,
    closeIconColor: AppColors.darkGreen,
    contentTextStyle: TextStyle(
      fontSize: FontSizeManager.f14,
      color: AppColors.darkBasePrimaryGray1,
      fontFamily: 'Hoves-regular',
    ),
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
