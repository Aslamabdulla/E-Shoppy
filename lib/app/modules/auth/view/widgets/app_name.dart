import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: 'E-',
          style: theme.textTheme.displayMedium
              ?.copyWith(color: theme.primaryColor, fontSize: 18.sp),
        ),
        TextSpan(
          text: 'Shoppy',
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
        ),
      ]),
    );
  }
}
