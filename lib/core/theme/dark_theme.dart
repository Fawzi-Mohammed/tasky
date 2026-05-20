import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/theme/app_text_styles.dart';
import 'package:tasky_app/core/theme/dark_colors.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.accent,
    onPrimary: DarkColors.onAccent,
    primaryContainer: DarkColors.surface,
    secondary: DarkColors.textSecondary,
    tertiary: DarkColors.muted,
  ),
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(double.infinity, AppSizes.h40),
      backgroundColor: DarkColors.accent,
      foregroundColor: DarkColors.onAccent,
      textStyle: AppTextStyles.button,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: DarkColors.textPrimary),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: DarkColors.accent,
    foregroundColor: DarkColors.onAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r30),
    ),
    extendedTextStyle: AppTextStyles.button,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.accent;
      }
      return DarkColors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.white;
      }
      return DarkColors.muted;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return DarkColors.muted;
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  scaffoldBackgroundColor: DarkColors.scaffold,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkColors.scaffold,
    titleTextStyle: AppTextStyles.regular(
      color: DarkColors.textPrimary,
      size: AppSizes.sp20,
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: DarkColors.textPrimary),
  ),
  useMaterial3: true,
  textTheme: TextTheme(
    displayMedium: AppTextStyles.regular(
      color: DarkColors.white,
      size: AppSizes.sp28,
    ),
    displaySmall: AppTextStyles.regular(
      color: DarkColors.white,
      size: AppSizes.sp24,
    ),
    displayLarge: AppTextStyles.regular(
      color: DarkColors.textPrimary,
      size: AppSizes.sp32,
    ),
    titleMedium: AppTextStyles.regular(
      color: DarkColors.textPrimary,
      size: AppSizes.sp16,
    ),
    titleSmall: AppTextStyles.regular(
      color: DarkColors.textSecondary,
      size: AppSizes.sp14,
    ),
    labelLarge: AppTextStyles.regular(
      color: DarkColors.white,
      size: AppSizes.sp24,
    ),
    labelMedium: AppTextStyles.regular(
      color: DarkColors.white,
      size: AppSizes.sp16,
    ),
    titleLarge: AppTextStyles.regular(
      color: DarkColors.textDone,
      size: AppSizes.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: DarkColors.strikeThrough,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: AppTextStyles.regular(
      color: DarkColors.textPrimary,
      size: AppSizes.sp20,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: AppSizes.w1 * 0.5),
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    hintStyle: AppTextStyles.regular(
      color: DarkColors.inputHint,
      size: AppSizes.sp16,
    ),
    filled: true,
    fillColor: DarkColors.surface,
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(width: AppSizes.w2, color: DarkColors.border),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.accent;
      }
      return Colors.transparent;
    }),
    checkColor: const WidgetStatePropertyAll(DarkColors.onAccent),
  ),
  iconTheme: const IconThemeData(color: DarkColors.textPrimary),
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyles.regular(
      color: DarkColors.textPrimary,
      size: AppSizes.sp16,
    ),
  ),
  dividerTheme: const DividerThemeData(color: DarkColors.border, thickness: 1),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: DarkColors.white,
    selectionHandleColor: DarkColors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DarkColors.scaffold,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: DarkColors.textSecondary,
    selectedItemColor: DarkColors.accent,
    unselectedLabelStyle: AppTextStyles.bottomNavUnselected,
    selectedLabelStyle: AppTextStyles.bottomNavSelected,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: DarkColors.scaffold,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      side: BorderSide(color: DarkColors.accent, width: AppSizes.w1),
    ),
    elevation: 2,
    shadowColor: DarkColors.accent,
    labelTextStyle: WidgetStatePropertyAll(
      AppTextStyles.regular(color: DarkColors.textPrimary, size: AppSizes.sp20),
    ),
  ),
);
