import 'package:e_shoppy/app/modules/auth/controller/auth_controller/auth_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthContrller>(
      () => AuthContrller(),
    );
  }
}
