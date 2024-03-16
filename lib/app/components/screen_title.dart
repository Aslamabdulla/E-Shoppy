// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_shoppy/config/theme/dark_theme_colors.dart';
import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:e_shoppy/config/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final double? dividerEndIndent;
  final IconData? icon;
  const ScreenTitle({
    super.key,
    required this.title,
    this.dividerEndIndent,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: !MyTheme().getThemeIsLight
                    ? LightThemeColors.backgroundColor
                    : DarkThemeColors.backgroundColor,
                size: 25,
              ),
            if (icon != null) 3.horizontalSpace,
            Text(title,
                style: context.theme.textTheme.displayLarge?.copyWith(
                  fontSize: 25.sp,
                )),
          ],
        ),
        Divider(
          thickness: 3,
          endIndent: dividerEndIndent ?? 250,
        ),
      ],
    );
  }
}
