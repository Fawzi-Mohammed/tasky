import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.size = 24,
    this.color,
    this.witheColorFilter = true,
  });
  const CustomSvgPicture.withColorFilter({
    super.key,
    required this.path,
    this.size = 24,
    this.color,
  }) : witheColorFilter = false;
  final String path;
  final double size;
  final Color? color;
  final bool witheColorFilter;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size.w,
      height: size.h,
      colorFilter: witheColorFilter
          ? ColorFilter.mode(
              color ?? Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
