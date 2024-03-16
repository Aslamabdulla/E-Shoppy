import 'dart:developer';

import 'package:e_shoppy/app/modules/auth/controller/auth_controller/auth_controller.dart';
import 'package:e_shoppy/utils/auth_helper/auth_helper.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    String? isAuthenticated = await AuthService.isSignedIn();
    log(isAuthenticated ?? "");
    await Future.delayed(const Duration(seconds: 2));
    if (isAuthenticated == null) {
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.offNamed(Routes.BASE);
    }

    super.onInit();
  }
}
