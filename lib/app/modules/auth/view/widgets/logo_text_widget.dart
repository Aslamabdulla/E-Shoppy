import 'package:e_shoppy/app/modules/auth/view/widgets/app_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppLogoTextWidget extends StatelessWidget {
  final String text;
  const AppLogoTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppLogoWidget(),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
