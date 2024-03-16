import 'dart:convert';
import 'dart:developer';

import 'package:e_shoppy/app/data/remote/api_service/api_service.dart';
import 'package:e_shoppy/app/data/remote/dio_service/dio_service.dart';
import 'package:e_shoppy/app/modules/base/controllers/base_controller.dart';
import 'package:e_shoppy/utils/end_points/end_points.dart';
import 'package:get/get.dart';

import '../../../../utils/dummy_helper/dummy_helper.dart';
import '../../../data/models/product_model/product_model.dart';

class HomeController extends GetxController {
  static HomeController get find => Get.find();
  List<ProductModel?> products = [];
  ApiService repo = DioService();
  bool isLoading = false;
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  getProducts() async {
    try {
      isLoading = true;
      update();
      final response = await repo.get(Endpoints.productApi);
      // log(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<ProductModel> jsonResponse = List<ProductModel>.from(json
            .decode(json.encode(response.data))
            .map((x) => ProductModel.fromJson(x)));
        products = jsonResponse;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
