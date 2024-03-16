import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    var theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeIn(
                child: Image.asset(
                  Constants.logo,
                  width: 120.w,
                  height: 100.h,
                ),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'E-',
                    style: theme.textTheme.displayMedium
                        ?.copyWith(color: theme.primaryColor, fontSize: 18.sp),
                  ),
                  TextSpan(
                    text: 'Shoppy',
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontSize: 18.sp),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
