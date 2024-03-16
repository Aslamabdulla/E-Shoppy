// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_shoppy/app/routes/app_pages.dart';

class SignUpTextWidget extends StatelessWidget {
  final String text;
  final String text2;
  const SignUpTextWidget({
    super.key,
    required this.text,
    required this.text2,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: theme.textTheme.displayMedium?.copyWith(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        5.horizontalSpace,
        GestureDetector(
          onTap: () {
            if (text2 == "Login") {
              Get.back();
            } else {
              Get.toNamed(Routes.SIGNUP);
            }
          },
          child: Text(
            text2,
            style: theme.textTheme.displayMedium
                ?.copyWith(fontSize: 14.sp, color: Colors.teal),
          ),
        )
      ],
    );
  }
}
