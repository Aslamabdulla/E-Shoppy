import 'dart:developer';

import 'package:e_shoppy/app/data/local/hive/hive_repo/hive_repo.dart';
import 'package:e_shoppy/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel?> products = [];
  static CartController get find => Get.find();
  // to hold the total price of the cart products
  var total = 0.0;
  HiveStorageRepo hiveRepo = HiveStorageRepo();
  @override
  void onInit() {
    getOfflineCategories();
    super.onInit();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() {
    Get.find<BaseController>().changeScreen(0);
    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  /// when the user press on increase button
  onIncreasePressed(int productId) {
    var product = products.firstWhere((p) => p?.id == productId);
    if ((product?.quantity ?? 0) > 19) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: "Error", message: "Maximum Qty Reached For The Item");
    } else {
      product?.quantity = product.quantity! + 1;
    }

    getCartTotal();
    update(['ProductQuantity']);
    hiveRepo.updateProduct(product);
  }

  /// when the user press on decrease button
  onDecreasePressed(int productId) async {
    var product = products.firstWhere((p) => p?.id == productId);

    if (product?.quantity != 0) {
      product?.quantity = (product.quantity ?? 0) - 1;
      if (product?.quantity == 0) {
        product?.quantity = 1;
        onDeletePressed(product?.id ?? -1);
        await hiveRepo.deleteProduct(productId.toString() ?? "");
      } else {
        hiveRepo.updateProduct(product);
      }
      getCartTotal();
      update(['ProductQuantity']);
    }
  }

  /// when the user press on delete icon
  onDeletePressed(int productId) async {
    //
    var index = products.indexWhere((p) => p?.id == productId);
    products?[index]?.quantity = 1;
    products.removeAt(index);
    getCartTotal();
    await hiveRepo.deleteProduct(productId.toString() ?? "");
  }

  /// get the cart products from the product list
  getCartTotal() {
    try {
      total = products.fold<double>(
          0, (p, c) => p + (c?.price ?? 0) * (c?.quantity ?? 0));
      update();
    } catch (e) {}
  }

  getOfflineCategories() async {
    try {
      final hiveResult = await hiveRepo.getCartItems();
      if (hiveResult?.isNotEmpty ?? false) {
        products = hiveResult ?? [];
        getCartTotal();
        update();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  bool addToCart(ProductModel? productModel) {
    try {
      // Check if the product already exists in the cart
      bool productExists = products.any((item) => item?.id == productModel?.id);

      if (!productExists) {
        // Product doesn't exist in the cart, add it
        products.add(productModel);
        hiveRepo.addSingleProduct(productModel);

        return true;
      } else {
        // Product already exists in the cart

        return false;
      }
    } catch (e) {
      return false;
    } finally {
      update();
    }
  }
}
