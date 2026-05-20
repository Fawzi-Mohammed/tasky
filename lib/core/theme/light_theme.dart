import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/theme/app_text_styles.dart';
import 'package:tasky_app/core/theme/light_colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: LightColors.accent,
    onPrimary: LightColors.onAccent,
    primaryContainer: LightColors.surface,
    secondary: LightColors.textSecondary,
    tertiary: LightColors.muted,
  ),
  dividerTheme: const DividerThemeData(color: LightColors.border, thickness: 1),
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(double.infinity, AppSizes.h40),
      backgroundColor: LightColors.accent,
      foregroundColor: LightColors.onAccent,
      textStyle: AppTextStyles.button,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.black),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: LightColors.black,
    selectionHandleColor: LightColors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: LightColors.accent,
    foregroundColor: LightColors.onAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r30),
    ),
    extendedTextStyle: AppTextStyles.button,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.accent;
      }
      return LightColors.surface;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.surface;
      }
      return LightColors.muted;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return LightColors.muted;
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  scaffoldBackgroundColor: LightColors.scaffold,
  appBarTheme: AppBarTheme(
    backgroundColor: LightColors.scaffold,
    titleTextStyle: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp20,
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: LightColors.textPrimary),
  ),
  useMaterial3: true,
  textTheme: TextTheme(
    displayMedium: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp28,
    ),
    displaySmall: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp24,
    ),
    displayLarge: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp32,
    ),
    titleMedium: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp16,
    ),
    titleSmall: AppTextStyles.regular(
      color: LightColors.textSecondary,
      size: AppSizes.sp14,
    ),
    labelMedium: AppTextStyles.regular(
      color: LightColors.black,
      size: AppSizes.sp16,
    ),
    labelLarge: AppTextStyles.regular(
      color: LightColors.black,
      size: AppSizes.sp24,
    ),
    titleLarge: AppTextStyles.regular(
      color: LightColors.textDone,
      size: AppSizes.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: LightColors.strikeThrough,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp20,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.border, width: AppSizes.w1),
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    focusColor: LightColors.border,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.border, width: AppSizes.w1),
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.border, width: AppSizes.w1),
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    hintStyle: AppTextStyles.regular(
      color: LightColors.muted,
      size: AppSizes.sp16,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: AppSizes.w1 * 0.5),
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    filled: true,
    fillColor: LightColors.surface,
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(width: AppSizes.w2, color: LightColors.border),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.accent;
      }
      return Colors.transparent;
    }),
    checkColor: const WidgetStatePropertyAll(LightColors.onAccent),
  ),
  iconTheme: const IconThemeData(color: LightColors.textPrimary),
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyles.regular(
      color: LightColors.textPrimary,
      size: AppSizes.sp16,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.scaffold,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: LightColors.textSecondary,
    selectedItemColor: LightColors.accentAlt,
    unselectedLabelStyle: AppTextStyles.bottomNavUnselected,
    selectedLabelStyle: AppTextStyles.bottomNavSelected,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: LightColors.scaffold,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    elevation: 2,
    shadowColor: LightColors.accent,
    labelTextStyle: WidgetStatePropertyAll(
      AppTextStyles.regular(color: LightColors.black, size: AppSizes.sp20),
    ),
  ),
);
