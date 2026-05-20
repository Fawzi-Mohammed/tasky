import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle regular({
    required Color color,
    required double size,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
      decoration: decoration,
      decorationColor: decorationColor,
      overflow: overflow,
    );
  }

  static TextStyle medium({required Color color, required double size}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w500);
  }

  static TextStyle semiBold({required Color color, required double size}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600);
  }

  static final TextStyle button = TextStyle(
    fontSize: AppSizes.sp14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bottomNavUnselected = TextStyle(
    fontSize: AppSizes.sp12,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bottomNavSelected = TextStyle(
    fontSize: AppSizes.sp12,
    fontWeight: FontWeight.w500,
  );
}
